import 'package:e_commerce_application/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  final VoidCallback? onPressed;
  const TUserProfileTile({
    super.key, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        image: TImages.user,
        height: 50,
        width: 50,
        padding: 0,
      ),
      title: Text(
        'Coding with T',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        'support@codingwitht.com',
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        icon: const Icon(
          Iconsax.edit,
          color: TColors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
