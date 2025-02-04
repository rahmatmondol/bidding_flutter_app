import 'package:dirham_uae/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/local/my_shared_pref.dart';
import 'app/data/local/token_manager.dart';
import 'app/data/user_service/user_service.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferences.getInstance();
  await MySharedPref.init();
  await Hive.initFlutter();
  var box = await Hive.openBox('mapBox');
  await TokenRefreshService().initialize();

  // Get initial route
  final initialRoute = await checkAuthState();

  runApp(MyApp(initialRoute: initialRoute));
}

Future<String> checkAuthState() async {
  UserService userService = UserService();
  bool? isUser = await userService.getBool();
  bool? isProviderUser = await userService.getBoolProvider();

  if (isUser == true) {
    return Routes.CUSTOMER_NAV_BAR;
  } else if (isProviderUser == true) {
    return Routes.NAV_BAR;
  }
  return Routes.SPLASH;
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          title: "Smart Bidding",
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          defaultTransition: Transition.fade,
          getPages: AppPages.routes,
          theme: MyTheme.getThemeData(isLight: MySharedPref.getThemeIsLight()),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
