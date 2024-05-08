import 'package:e_commerce_application/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboard_dot_navigation.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboarding_circular_button.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboarding_skip_button_widget.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/widgets/onboardingwidget.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          // horizontal scroll view
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingWidget(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingWidget(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingWidget(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          // Skip Button
          const OnBoardingSkipButton(),
          // Navigation Smooth page Indicator
          const OnBoardDotNavigation(),
          // Get Started Button
          const OnBoardingCircularButton()
        ],
      ),
    );
  }
}
