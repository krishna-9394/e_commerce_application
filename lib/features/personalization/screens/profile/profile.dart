import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/common/widgets/images/circular_image.dart';
import 'package:e_commerce_application/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_application/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce_application/features/personalization/screens/profile/widget/change_name.dart';
import 'package:e_commerce_application/features/personalization/screens/profile/widget/profile_menu.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(
                      image: TImages.user,
                      height: 80,
                      width: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(
                () => TProfileMenu(
                  question: 'Name',
                  answer: controller.user.value.fullName,
                  onPressed: () => Get.to(() => const ChangeName()),
                ),
              ),
              TProfileMenu(
                  question: 'UserName', answer: controller.user.value.userName),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                question: 'User ID',
                answer: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                question: 'Email',
                answer: controller.user.value.email,
              ),
              TProfileMenu(
                question: 'Phone Number',
                answer: controller.user.value.phoneNumber,
              ),
              const TProfileMenu(
                question: 'Gender',
                answer: 'male',
              ),
              const TProfileMenu(
                question: 'Date of Birth',
                answer: '10 Oct, 1994',
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextButton(
                onPressed: () => controller.deleteAccountWarningPopup(),
                child: const Text(
                  'Close Account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
