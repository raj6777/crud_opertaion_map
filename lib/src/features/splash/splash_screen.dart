import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:googlemap/src/features/splash/splash_helper.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final SplashHelper splashHelper = SplashHelper();

  @override
  void initState() {
    FlutterNativeSplash.remove();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Color(0xff384740),
      body: Stack(
        children: [
          ///Splash Background Image
          splashHelper.splashBgImageWidgets(),

          ///AppLogo Animation
          Center(child: splashHelper.buildScaleTransition()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    splashHelper.doAnimationNotifier.dispose();
    splashHelper.moveToTop.dispose();
    super.dispose();
  }
}
