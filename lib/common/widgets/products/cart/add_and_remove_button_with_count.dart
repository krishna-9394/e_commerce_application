import 'package:e_commerce_application/common/widgets/icon/t_circular_icon.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductQuantityWithRemoveButton extends StatelessWidget {
  final int quantity;
  final VoidCallback? add, remove;
  const TProductQuantityWithRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: TSizes.md,
          onPressed: remove,
          color: THelperFunctions.isDarkMode(context)
              ? Colors.white
              : Colors.black,
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        TCircularIcon(
            icon: Iconsax.add,
            width: 32,
            height: 32,
            size: TSizes.md,
            color: Colors.black,
            backgroundColor: TColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
