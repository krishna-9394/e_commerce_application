import 'package:e_commerce_application/common/widgets/custom_shape/container/circular_container.dart';
import 'package:e_commerce_application/data/repositories/address/address_repository.dart';
import 'package:e_commerce_application/features/personalization/models/address_model.dart';
import 'package:e_commerce_application/features/personalization/screens/addresses/addresses.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/helpers/network_manager.dart';
import 'package:e_commerce_application/utils/popups/full_screen_loaders.dart';
import 'package:e_commerce_application/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  // Fetch all user specific addresses
  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUsersAddress();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Address not found", message: e.toString());
      return [];
    }
  }

  // update the addresses
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CircularProgressIndicator());

      // clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // set the selected field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(title: "Address not found", message: e.toString());
    }
  }

  Future addNewAddress() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Address...', TImages.docerAnimation);

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Address
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addNewAddress(address);

      // update selected address
      address.id = id;
      await selectAddress(address);

      // Remove Loaders
      TFullScreenLoader.stopLoading();

      // show Success message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your address has been saved successfully',
      );

      // refresh Addresses data
      refreshData.toggle();

      // reset field
      resetFormField();

      // redirecting to addresses screens
      Get.to(() => const UserAddressScreen());
    } catch (e) {
      // remove loaders
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  resetFormField() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
