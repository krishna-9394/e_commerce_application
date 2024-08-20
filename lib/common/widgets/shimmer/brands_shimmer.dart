import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class TBrandShimmer extends StatelessWidget {
  const TBrandShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      mainAxisExtent: 80,
      itemBuiler: (_, __) => const TShimmerEffect(width: 300, height: 80),
    );
  }
}
