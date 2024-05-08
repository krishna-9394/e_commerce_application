import 'package:e_commerce_application/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        child: const Text("Skip"),
        onPressed: () => OnBoardingController.instance.skipPage(),
      ),
    );
  }
}
