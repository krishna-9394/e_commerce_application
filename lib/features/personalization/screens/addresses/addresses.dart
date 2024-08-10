import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_application/features/personalization/screens/addresses/add_new_address.dart';
import 'package:e_commerce_application/features/personalization/screens/addresses/widget/single_address.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(
          () => const AddNewAddressScreen(),
        ),
        child: const Icon(Iconsax.add, color: Colors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
                future: controller.allUserAddresses(),
                builder: (context, snapshot) {
                  // Helper Function: handles Loaders, No Records, or Error Message
                  final response = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
            
                  if (response != null) return response;
                  // Records found
                  final addresses = snapshot.data!;
            
                  return ListView.builder(
                    itemCount: addresses.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TSingleAddress(
                        address: addresses[index],
                        onTap: () => controller.selectAddress(addresses[index]),
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}
