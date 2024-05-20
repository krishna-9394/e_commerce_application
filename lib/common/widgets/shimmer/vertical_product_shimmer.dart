import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_efftect.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TVerticalProductShimmer extends StatelessWidget {
  final int itemCount;
  const TVerticalProductShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      itemBuiler: (_, index) => const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              TShimmerEfftect(width: 180, height: 15),
              SizedBox(height: TSizes.spaceBtwItems),
              // Text
              TShimmerEfftect(width: 160, height: 180),
              SizedBox(height: TSizes.spaceBtwItems / 2),
              TShimmerEfftect(width: 110, height: 15),
            ],
          )),
    );
  }
}
