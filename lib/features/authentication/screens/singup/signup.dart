import 'package:e_commerce_application/common/widgets/authentication_widgets/bottom_icon_button.dart';
import 'package:e_commerce_application/common/widgets/authentication_widgets/divider.dart';
import 'package:e_commerce_application/features/authentication/screens/singup/widgets/signup_form.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Form
              SignupForm(isDark: isDark),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Divider
              TDivider(isDark: isDark, title: TTexts.orSignUpWith),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Social Media Button
              const BottomIconButton()
            ],
          ),
        ),
      ),
    );
  }
}
