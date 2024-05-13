import 'package:e_commerce_application/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:e_commerce_application/data/repositories/user/user_repository.dart';
import 'package:e_commerce_application/features/authentication/screens/singup/verify_email.dart';
import 'package:e_commerce_application/features/personalization/models/user_model.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/popups/full_screen_loaders.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  // Rx variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  // update the hidePassword
  void updatePasswordStatus() {
    hidePassword.value = !hidePassword.value;
  }

  // update the privacy policy status
  void updatePrivacyPolicyStatus(value) {
    privacyPolicy.value = value;
  }

  // Signup
  Future<void> singup() async {
    try {
      // start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing the information...', TImages.docerAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!signupKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Privacy Policy
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you have to read and accept the Privacy Policy & Terms of Use');
      }
      // Register the user in the firebase Authentication & save user data in firestore
      final userCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();

      // show success message
      TLoaders.successSnackBar(
          title: "Congratulations",
          message: "Your account has been created! Verfiy email to continue.");
      // move to verfiy Email Screen
      Get.to(() => VerifyEmailScreen(email: newUser.email,));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      //  Show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
