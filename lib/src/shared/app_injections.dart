

import '../../main.dart';
import 'data/data_sources/app_shared_prefs.dart';

initAppInjections() {
  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}
