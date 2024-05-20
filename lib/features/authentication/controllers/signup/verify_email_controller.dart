import 'dart:async';

import 'package:e_commerce_application/common/widgets/success_screen/success_screen.dart';
import 'package:e_commerce_application/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send the Email whenever verify screen appears & Set Timer for redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEMailVerification();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    }
  }

  /// Timer to automatically redirect on Email Verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: TImages.successfullyRegisterAnimotion,
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  /// Manually check if Email is verified
  checkEmailVerificationStatus() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    print(currentUser!.emailVerified);
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: TImages.successfullyRegisterAnimotion,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
