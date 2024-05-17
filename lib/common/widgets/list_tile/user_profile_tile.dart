import 'package:e_commerce_application/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  final VoidCallback? onPressed;
  const TUserProfileTile({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(
      () => ListTile(
        leading: const TCircularImage(
          image: TImages.user,
          height: 50,
          width: 50,
          padding: 0,
        ),
        title: Text(
          controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white),
        ),
        subtitle: Text(
          controller.user.value.email,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: TColors.white,
              ),
        ),
        trailing: IconButton(
          icon: const Icon(
            Iconsax.edit,
            color: TColors.white,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
