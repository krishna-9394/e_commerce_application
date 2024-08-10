import 'package:e_commerce_application/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_application/features/shop/screens/home/home.dart';
import 'package:e_commerce_application/features/personalization/screens/setting/settings.dart';
import 'package:e_commerce_application/features/shop/screens/store/store.dart';
import 'package:e_commerce_application/features/shop/screens/wishlist/wishlist.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: isDarkMode ? TColors.dark : TColors.white,
          indicatorColor: isDarkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.dark.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Shop'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishlistScreen(),
    const SettingScreen(),
  ];
}
