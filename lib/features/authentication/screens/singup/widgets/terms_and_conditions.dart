import 'package:e_commerce_application/features/authentication/controllers/signup/singup_controller.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:e_commerce_application/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.updatePrivacyPolicyStatus(value))),
          ),
          const SizedBox(width: TSizes.spaceBtwItems),
          SizedBox(
            width: screenWidth * 0.75,
            child: Text.rich(
              softWrap: true,
              maxLines: 2,
              TextSpan(
                children: [
                  TextSpan(
                    text: '${TTexts.iAgreeTo} ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: '${TTexts.privacyPolicy} ',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          decorationColor:
                              isDark ? TColors.white : TColors.primary,
                          color: isDark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                  TextSpan(
                    text: '${TTexts.and} ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: TTexts.termsOfUse,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          decorationColor:
                              isDark ? TColors.white : TColors.primary,
                          color: isDark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
