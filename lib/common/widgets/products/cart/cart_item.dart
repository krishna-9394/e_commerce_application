import 'package:e_commerce_application/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_application/common/widgets/texts/brand_title_text_with_verified_symbol.dart';
import 'package:e_commerce_application/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_application/features/shop/models/cart_item_model.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TCardItem extends StatelessWidget {
  final CartItemModel cartItemModel;
  const TCardItem({
    super.key,
    required this.cartItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageURL: cartItemModel.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleTextWithVerifiedSymbol(
                  title: cartItemModel.brandName ?? ""),
              Flexible(
                child: TProductTitleText(
                  title: cartItemModel.title,
                  maxline: 1,
                ),
              ),

              /// Attribute
              Text.rich(
                TextSpan(
                  children: (cartItemModel.selectedVariation ?? {})
                      .entries
                      .map((e) => TextSpan(
                            children: [
                              TextSpan(
                                  text: ' ${e.key} ',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                  text: e.value,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
