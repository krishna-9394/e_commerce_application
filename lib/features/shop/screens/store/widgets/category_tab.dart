import 'package:e_commerce_application/common/widgets/brands/brand_show_case.dart';
import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  final List<String> images;
  final String title, subTitle;

  const TCategoryTab({
    super.key,
    required this.images,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand
              TBrandShowCase(
                images: images,
                title: title,
                subTitle: subTitle,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TBrandShowCase(
                images: images,
                title: title,
                subTitle: subTitle,
              ),

              /// Products
              TSectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TGridLayout(
                itemCount: 4,
                itemBuiler: (_, index) => const TVerticalProductCard(),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}
