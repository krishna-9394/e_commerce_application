import 'package:e_commerce_application/bindings/genernal_bindings.dart';
import 'package:e_commerce_application/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_application/firebase_options.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/routes/app_routes.dart';
import 'package:e_commerce_application/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  // Widget Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  // Getx-Local Storage
  await GetStorage.init();
  // Await Splash untill item loads
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBinding(),
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      getPages: AppRoutes.pages,
      // show Loader or Circular Progress meanwhile Authentication repository will decide show screen
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
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

// TODO: solve this error which pops out during the login
// User JsonReader.setListener(true) to accept malformed JSON at path