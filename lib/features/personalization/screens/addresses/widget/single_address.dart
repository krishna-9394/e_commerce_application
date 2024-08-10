import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_application/features/personalization/models/address_model.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap,});
  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return GestureDetector(
        onTap: onTap,
        child: TRoundedContainer(
          showBorder: true,
          width: double.infinity,
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor:
              selectedAddress ? TColors.primary.withOpacity(0.5) : Colors.transparent,
          borderColor: address.selectedAddress
              ? Colors.transparent
              : isDark
                  ? TColors.darkGrey
                  : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color:
                      selectedAddress ? (isDark ? TColors.light : TColors.dark) : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    address.fomattedPhoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    address.toString(),
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
      }
    );
  }
}
