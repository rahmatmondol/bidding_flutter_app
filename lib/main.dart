// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'app/data/local/my_shared_pref.dart';
// import 'app/data/user_service/user_service.dart'; // Add this import
// import 'app/routes/app_pages.dart';
// import 'config/theme/my_theme.dart';
//
// Future<void> main() async {
//   // wait for bindings
//   WidgetsFlutterBinding.ensureInitialized();
//   await SharedPreferences.getInstance();
//   // init shared preference
//   await MySharedPref.init();
//   await Hive.initFlutter();
//   var box = await Hive.openBox('mapBox');
//
//   // Check authentication status
//   final initialRoute = await checkInitialRoute();
//
//   runApp(
//     ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       useInheritedMediaQuery: true,
//       rebuildFactor: (old, data) => true,
//       builder: (context, widget) {
//         return GetMaterialApp(
//           title: "Smart Bidding",
//           useInheritedMediaQuery: true,
//           debugShowCheckedModeBanner: false,
//           builder: (context, widget) {
//             bool themeIsLight = MySharedPref.getThemeIsLight();
//             return Theme(
//               data: MyTheme.getThemeData(isLight: themeIsLight),
//               child: MediaQuery(
//                 data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//                 child: widget!,
//               ),
//             );
//           },
//           initialRoute: initialRoute,
//           getPages: AppPages.routes,
//         );
//       },
//     ),
//   );
// }
//
// Future<String> checkInitialRoute() async {
//   UserService userService = UserService();
//   var isUser = await userService.getBool();
//   var isProviderUser = await userService.getBoolProvider();
//
//   if (isUser == true) {
//     return Routes.CUSTOMER_NAV_BAR;
//   } else if (isProviderUser == true) {
//     return Routes.NAV_BAR;
//   }
//   return Routes.SPLASH; // This should be your login route
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/local/my_shared_pref.dart';
import 'app/data/user_service/user_service.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await MySharedPref.init();
  await Hive.initFlutter();
  var box = await Hive.openBox('mapBox');

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
