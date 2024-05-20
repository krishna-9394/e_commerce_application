import 'package:e_commerce_application/common/widgets/shimmer/shimmer_efftect.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            TShimmerEfftect(width: 50, height: 50, radius: 50),
            SizedBox(width: TSizes.spaceBtwItems),
            Column(
              children: [
                TShimmerEfftect(width: 100, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                TShimmerEfftect(width: 80, height: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}
