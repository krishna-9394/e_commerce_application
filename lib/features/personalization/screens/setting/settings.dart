import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/container/curved_edges_widget_container.dart';
import 'package:e_commerce_application/common/widgets/list_tile/setting_menu_tile.dart';
import 'package:e_commerce_application/common/widgets/list_tile/user_profile_tile.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:e_commerce_application/features/personalization/screens/addresses/addresses.dart';
import 'package:e_commerce_application/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce_application/features/shop/screens/cart/cart.dart';
import 'package:e_commerce_application/features/shop/screens/order/order.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryCurvedEdgesWidget(
              child: Column(
                children: [
                  /// AppBar
                  TAppBar(
                    showBackArrow: false,
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: Colors.white),
                    ),
                  ),

                  /// Profile Card
                  TUserProfileTile(
                    onPressed: () => Get.to(
                      const ProfileScreen(),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// body
                  const TSectionHeading(
                    title: 'Account Setting',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingMenuTile(
                    title: 'My Addresses',
                    subTitle: 'set shopping delivery addresses',
                    icon: Iconsax.safe_home,
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingMenuTile(
                    title: 'My Cart',
                    subTitle: 'Add, remove Product and move to checkout',
                    icon: Iconsax.shopping_cart,
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  TSettingMenuTile(
                    title: 'My Orders',
                    subTitle: 'In-Progress and Completed Orders',
                    icon: Iconsax.bag_tick,
                    onTap: () => Get.to(() => const MyOrderScreen()),
                  ),
                  TSettingMenuTile(
                    title: 'Bank Accounts',
                    subTitle: 'Withdraw Balance to registered Bank Account',
                    icon: Iconsax.bank,
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    title: 'My Coupons',
                    subTitle: 'List of all discounted Coupons',
                    icon: Iconsax.discount_shape,
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    title: 'Notification',
                    subTitle: 'Set any kind of notification message',
                    icon: Iconsax.notification,
                    onTap: () {},
                  ),
                  TSettingMenuTile(
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected accounts',
                    icon: Iconsax.security_card,
                    onTap: () {},
                  ),

                  /// app setting
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                    title: 'App Setting',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingMenuTile(
                    title: 'Load Data',
                    subTitle: 'Upload data to your cloud firebase',
                    icon: Iconsax.document_upload,
                    onTap: () {},
                  ),

                  TSettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: const Text('Logout'),
                      onPressed: () => AuthenticationRepository.instance.logout(),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
