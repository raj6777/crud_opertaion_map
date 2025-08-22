import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:googlemap/src/core/helper/helper.dart';
import 'package:googlemap/src/core/route/router.dart';
import 'package:googlemap/src/core/style/app_theme.dart';
import 'package:googlemap/src/core/translations/l10n.dart';
import 'package:googlemap/src/core/utils/constant/app_constants.dart';
import 'package:googlemap/src/core/utils/injections.dart';
import 'package:googlemap/src/features/todo/bloc/objectboxwrapper/ObjectBox.dart';
import 'package:googlemap/src/features/todo/bloc/rememberme/RememberMeBloc.dart';
import 'package:googlemap/src/features/todo/provider/TaskProvider.dart';

import 'package:googlemap/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:googlemap/src/shared/domain/entities/language_enum.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
GetIt sl = GetIt.instance;
late final ObjectBox objectBox;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Inject all dependencies
  await initInjections();
  objectBox = await ObjectBox.create();

  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
            create: (_) => Remembermebloc(sharedPrefs: sl<AppSharedPrefs>())),
        ChangeNotifierProvider(create: (_) => AppNotifier()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: DevicePreview(
        builder: (context) {
          return const App();
        },
        enabled: false,
      ),
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        LanguageEnum newLocale = Helper.getLang();
        context.read<AppNotifier>().setLocale(context, newLocale);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (context, value, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              title: appName,
              scaffoldMessengerKey: snackBarKey,
              routerConfig: AppAutoRouter().config(),
              theme: value.isDarkMode ? darkAppTheme : appTheme,
              debugShowCheckedModeBanner: false,
              locale: value.locale,
              builder: (context, child) {
                return SafeArea(
                  top: false,
                  bottom: true,
                  maintainBottomViewPadding: true,
                  child: Scaffold(
                    body: Column(
                      children: [
                        Expanded(child: child!),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          height: value.isConnected ? 0 : 50,
                          color: Theme.of(context).colorScheme.errorContainer,
                          child: value.isConnected
                              ? const SizedBox.shrink()
                              : Center(
                            child: Text(
                              S.of(context).no_internet_connection,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale("ar"),
                Locale("en"),
              ],
            );
          },
        );
      },
    );
  }
}

class AppNotifier extends ChangeNotifier {
  late bool darkTheme;
  Locale locale = const Locale("en");

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  bool isConnected = true;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  AppNotifier() {
    _initialise();
  }

  Future _initialise() async {
    await initialize();
    darkTheme = Helper.isDarkTheme();
    notifyListeners();
  }

  Future<void> initialize() async {
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    updateConnectivityStatus(result);

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
          updateConnectivityStatus(result);
        });
  }

  void updateConnectivityStatus(List<ConnectivityResult> result) {
    // If the list is empty, or contains none, or is none itself then no internet.
    // (the last condition is important on iOS)
    if (result.contains(ConnectivityResult.none) || result.isEmpty) {
      isConnected = false;
    } else if (result.contains(ConnectivityResult.mobile) ||
               result.contains(ConnectivityResult.wifi) ||
               result.contains(ConnectivityResult.ethernet) ||
               result.contains(ConnectivityResult.vpn) ||
               result.contains(ConnectivityResult.bluetooth) ||
               result.contains(ConnectivityResult.other)) {
      isConnected = true;
    }
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    sl<AppSharedPrefs>().setDarkTheme(_isDarkMode);
    _isDarkMode = Helper.isDarkTheme();
    debugPrint("Theme toggled: $_isDarkMode");
    notifyListeners();
  }

  void updateThemeTitle(bool newDarkTheme) {
    darkTheme = newDarkTheme;
    if (Helper.isDarkTheme()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }

  void setLocale(BuildContext context, LanguageEnum newLocale) {
    locale = Locale(newLocale.name);
    notifyListeners();
    sl<AppSharedPrefs>().setLang(newLocale);
  }
}
