import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/icon/t_circular_icon.dart';
import 'package:e_commerce_application/common/widgets/layout/grid_layout.dart';
import 'package:e_commerce_application/common/widgets/loader/animation_loader.dart';
import 'package:e_commerce_application/common/widgets/products/product_cards/vertical_product_card.dart';
import 'package:e_commerce_application/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_application/features/shop/controllers/product/favourite_controller.dart';
import 'package:e_commerce_application/features/shop/models/products/product_model.dart';
import 'package:e_commerce_application/features/shop/screens/home/home.dart';
import 'package:e_commerce_application/navigation_menu.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(
              const HomeScreen(),
            ),
          )
        ],
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => FutureBuilder(
                  future: controller.favouriteProducts(),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer(
                      itemCount: 6,
                    );

                    final emptyWidget = TAnimationLoaderWidget(
                      text: 'Whoops! Wishlist is Empty...',
                      animation: TImages.pencilAnimation,
                      showAction: true,
                      actionText: 'Let\'s add some',
                      onActionPressed: () =>
                          Get.offAll(() => const NavigationMenu()),
                    );

                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader, nothingFound: emptyWidget);

                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    return TGridLayout(
                      itemCount: products.length,
                      itemBuiler: (_, index) => TVerticalProductCard(
                        product: products[index],
                      ),
                    );
                  }),
            )),
      ),
    );
  }
}
