import 'package:e_commerce_application/common/widgets/products/cart/add_and_remove_button_with_count.dart';
import 'package:e_commerce_application/common/widgets/products/cart/cart_item.dart';
import 'package:e_commerce_application/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  final bool showAddRemoveButton;
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) => Column(
              children: [
                const TCardItem(),
                if(showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems),
                if(showAddRemoveButton) const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 70),
                        TProductQuantityWithRemoveButton(),
                      ],
                    ),
                    TProductPriceText(price: '256')
                  ],
                )
              ],
            ),
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemCount: 2,);
  }
}
