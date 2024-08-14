import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(
            title: 'Shopping Address',
            showActionButton: true,
            buttonTitle: 'Change',
            onPressed: () => controller.selectNewAddressPopup(context),
          ),
          Obx(() {
            return controller.selectedAddress.value.id.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.selectedAddress.value.name,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 16),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Text(
                      controller.selectedAddress.value.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.location_history,
                        color: Colors.grey, size: 16),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Flexible(
                      flex: 1,
                      child: Text(
                        '${controller.selectedAddress.value.street}, ${controller.selectedAddress.value.city}, ${controller.selectedAddress.value.state}-${controller.selectedAddress.value.postalCode}, ${controller.selectedAddress.value.country}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            )
                : Text(
              'Select Address',
              style: Theme.of(context).textTheme.bodyMedium,
            );
          }),
        ],
      ),
    );
  }
}
