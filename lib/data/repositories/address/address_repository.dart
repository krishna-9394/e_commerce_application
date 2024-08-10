import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_application/features/personalization/models/address_model.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUsersAddress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find users Information, Try again in few minutes.';
      }

      final results = await _db
          .collection('users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return results.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw ('Something went wrong while fetching Address Information. Try again later.');
    }
  }

  // clear the selected field for all address
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAdress': selected});
    } catch (e) {
      throw 'Unable to update your address selection. Try again later';
    }
  }

  // clear the selected field for all address
  Future<String> addNewAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Unable to update your address selection. Try again later';
    }
  }
}
