import 'package:e_commerce_application/common/widgets/shimmer/shimmer_efftect.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class THorizontalProductShimmer extends StatelessWidget {
  final int itemCount;
  const THorizontalProductShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Images
            TShimmerEfftect(width: 120, height: 120),
            SizedBox(width: TSizes.spaceBtwItems),
            // Text
            Column(
              children: [
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShimmerEfftect(width: 160, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShimmerEfftect(width: 110, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShimmerEfftect(width: 80, height: 15),
              ],
            )
          ],
        ),
        separatorBuilder: (_, __) =>
            const SizedBox(width: TSizes.spaceBtwItems),
      ),
    );
  }
}
