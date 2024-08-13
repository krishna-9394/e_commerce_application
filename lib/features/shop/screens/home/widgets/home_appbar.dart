import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/shimmer/shimmer_efftect.dart';
import 'package:e_commerce_application/common/widgets/products/cart/cart_counter_icon_button.dart';
import 'package:e_commerce_application/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce_application/features/shop/screens/cart/cart.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      showBackArrow: false,
      iconData: null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const TShimmerEfftect(
                width: 80,
                height: 15,
              );
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.white),
              );
            }
          }),
        ],
      ),
      actions: const [
        TCartCounterIconButton(
          iconColor: TColors.white,
          counterBackgroundColor: TColors.black,
          counterTextColor: TColors.white,
        )
      ],
    );
  }
}
