import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/shop/controllers/product/checkout_controller.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final controller = CheckoutController.instance;
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Obx(() => Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: isDark ? TColors.light : TColors.white,
              child: Image(
                image: AssetImage(controller.selectedPaymentMethod.value.image),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text(
              controller.selectedPaymentMethod.value.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        )),
      ],
    );
  }
}
