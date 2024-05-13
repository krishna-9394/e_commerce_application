import 'package:e_commerce_application/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:e_commerce_application/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/popups/full_screen_loaders.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmai() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Remove loading animation
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link sent to Reset your password.');

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim(),));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      //  Show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Resend Reset Password Email
  resendPasswordResetEmai(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.trim());

      // Remove loading animation
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link sent to Reset your password.');

      // Redirect
      Get.to(() => ResetPasswordScreen(
            email: email.trim(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      //  Show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
