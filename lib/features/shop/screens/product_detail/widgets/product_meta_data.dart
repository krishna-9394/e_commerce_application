import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application/common/widgets/texts/brand_title_text_with_verified_symbol.dart';
import 'package:e_commerce_application/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_application/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_application/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/dummy_data.dart';
import 'package:e_commerce_application/utils/constants/enums.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductMetaData extends StatelessWidget {
  final ProductModel product;
  const TProductMetaData({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSaleDiscount(product.price, product.salePrice);
    final price = controller.getProductPrice(product);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price and Sales Tag
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Sale Tag
            TRoundedContainer(
              borderRadius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Price Tag
            if(product.productType == ProductType.single.toString() && product.salePrice > 0.0)
              TProductPriceText(
                price: product.price.toString(),
                addCurrencySymbol: true,
                isSmall: true,
                isLarge: false,
                lineThrough: true,
              ),
            if(product.productType == ProductType.single.toString() && product.salePrice > 0.0)
              const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(price: price, isLarge: true),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        TProductTitleText(title: product.title),

        /// Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'Status :'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: Colors.green)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            TCircularImage(
              image: product.brand != null ? product.brand!.image : "",
              width: 32,
              height: 32,
              isNetworkImage: false,
              fit: BoxFit.contain,
              overlay: isDark ? Colors.white : Colors.black,
            ),
            TBrandTitleTextWithVerifiedSymbol(
              title: product.brand !=null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
