import 'package:e_commerce_application/common/widgets/custom_shape/container/rounded_container.dart';
import 'package:e_commerce_application/features/shop/screens/product_review/widgets/rating_indicator_using_stars.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/constants/image_strings.dart';
import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class TUserReviewCard extends StatelessWidget {
  const TUserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage(TImages.userProfileImage1)),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  'John Snow',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const TRatingIndicatorWIthStars(rating: 4.0),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('01 Nov, 2023', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const ReadMoreText(
          'The User interface of the app is quite Intutive. I was able to navigate and make purchase seamlessly.\n Great Job!',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show More',
          trimExpandedText: ' Show Less',
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: TColors.primary,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Companies Reply.
        TRoundedContainer(
          backgroundColor: isDark ? TColors.darkGrey : TColors.grey,
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Laxmi Enterprises',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '01 Nov, 2023',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const ReadMoreText(
                'The User interface of the app is quite Intutive. I was able to navigate and make purchase seamlessly.\n Great Job!',
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Show More',
                trimExpandedText: ' Show Less',
                moreStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: TColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
      ],
    );
  }
}
