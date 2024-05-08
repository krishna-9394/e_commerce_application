import 'package:e_commerce_application/common/widgets/authentication_widgets/bottom_icon_button.dart';
import 'package:e_commerce_application/common/widgets/authentication_widgets/divider.dart';
import 'package:e_commerce_application/features/authentication/screens/login/widgets/login_header.dart';
import 'package:e_commerce_application/features/authentication/screens/login/widgets/login_form.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/constants/text_strings.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSizes.appBarHeight,
            bottom: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              /// Logo, title, and subtitle
              AuthenticationHeaders(
                isDark: isDark,
                title: TTexts.loginTitle,
                subtitle: TTexts.loginSubTitle,
                image: isDark ? TImages.lightAppLogo : TImages.darkAppLogo,
              ),

              /// Login Form
              const LoginForm(),

              /// Divider
              TDivider(
                isDark: isDark,
                title: TTexts.orSignInWith,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Footer
              const BottomIconButton()
            ],
          ),
        ),
      ),
    );
  }
}
