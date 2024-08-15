import 'package:e_commerce_application/features/authentication/screens/login/login.dart';
import 'package:e_commerce_application/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce_application/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commerce_application/features/authentication/screens/signup/signup.dart';
import 'package:e_commerce_application/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce_application/features/personalization/screens/addresses/addresses.dart';
import 'package:e_commerce_application/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce_application/features/personalization/screens/setting/settings.dart';
import 'package:e_commerce_application/features/shop/screens/cart/cart.dart';
import 'package:e_commerce_application/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce_application/features/shop/screens/home/home.dart';
import 'package:e_commerce_application/features/shop/screens/order/order.dart';
import 'package:e_commerce_application/features/shop/screens/product_review/product_review.dart';
import 'package:e_commerce_application/features/shop/screens/store/store.dart';
import 'package:e_commerce_application/features/shop/screens/wishlist/wishlist.dart';
import 'package:e_commerce_application/utils/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const WishlistScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingScreen()),
    GetPage(
        name: TRoutes.productReviews, page: () => const ProductReviewScreen()),
    GetPage(name: TRoutes.order, page: () => const MyOrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen(email: '')),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ResetPasswordScreen(email: '',)),
    GetPage(name: TRoutes.onBoarding, page: () => const OnboardingScreen()),
  ];
// Add more GetPage entries as needed
}
