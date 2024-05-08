import 'package:e_commerce_application/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce_application/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}

// flutter pub run flutter_native_splash:create --path=splash.yaml 
// flutter pub run flutter_native_splash:remove
// use this command to run create the splash screen and remove the splash screen.


// dart fix --dry-run
// command to identify the fixes 

// dart fix --aply --code=unused_import
// dart fix --aply --code=unnecessary_import