import 'package:e_commerce_application/features/personalization/controllers/upload_data_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TUploadingMenuTile extends StatelessWidget {
  const TUploadingMenuTile({
    super.key,
    required this.controller,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.option,
  });

  final UploadDataController controller;
  final String title;
  final IconData icon;
  final Function() onPressed;
  final uploads option;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(
              width: TSizes.md,
            ),
            Text(title),
          ],
        ),
        Obx(
          () => IconButton(
            onPressed: onPressed,
            icon: (controller.isUploading.value &&
                    controller.whichUpload.value == option)
                ? const Icon(Iconsax.export2)
                : const Icon(Iconsax.arrow_up_1),
          ),
        ),
      ],
    );
  }
}
