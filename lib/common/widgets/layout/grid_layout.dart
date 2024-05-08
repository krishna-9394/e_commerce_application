import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TGridLayout extends StatelessWidget {
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuiler;
  final double? mainAxisExtent;
  const TGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuiler,
    this.mainAxisExtent = 288,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: mainAxisExtent,
          mainAxisSpacing: TSizes.gridViewSpacing,
          crossAxisSpacing: TSizes.gridViewSpacing,
        ),
        itemBuilder: itemBuiler);
  }
}
