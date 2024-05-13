import 'package:e_commerce_application/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_application/features/shop/screens/product_review/widgets/rating_indicator_using_stars.dart';
import 'package:e_commerce_application/features/shop/screens/product_review/widgets/rating_progress_indictor.dart';
import 'package:e_commerce_application/features/shop/screens/product_review/widgets/user_review_card.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar
      appBar: TAppBar(title: Text('Reviews & Rating'), showBackArrow: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Reveiws and Rating are from the verified and are from people who use the same type of device that you use'),
            SizedBox(height: TSizes.spaceBtwItems),

            /// Overall Rating 
            TOverallProductRating(),
            TRatingIndicatorWIthStars(rating: 3.9),
            Text('12,961', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(height: TSizes.spaceBtwSections),

            /// Users Review List
            TUserReviewCard(),
            TUserReviewCard(),
            TUserReviewCard(),
          ],
        ),
      ),
    );
  }
}
