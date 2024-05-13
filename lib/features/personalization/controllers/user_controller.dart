import 'package:e_commerce_application/data/repositories/user/user_repository.dart';
import 'package:e_commerce_application/features/personalization/models/user_model.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final user = userCredential.user;
        // convert Name to first and last name
        final nameParts = UserModel.nameParts(user!.displayName ?? "");
        final username = UserModel.getUsername(user.displayName ?? "");

        final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts[1] : "",
          userName: username,
          email: userCredential.user!.email ?? "",
          phoneNumber: userCredential.user!.phoneNumber ?? "",
          profilePicture: userCredential.user!.photoURL ?? "",
        );

        // save user data
        await userRepository.saveUserRecord(newUser);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your profile.');
    }
  }
}
