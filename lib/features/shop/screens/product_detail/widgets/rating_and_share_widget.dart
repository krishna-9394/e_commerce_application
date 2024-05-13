import 'package:e_commerce_application/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RatingAndShare extends StatelessWidget {
  final double rating;
  final int reviewCount;
  const RatingAndShare({
    super.key, required this.rating, required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Rating
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "$rating ",
                      style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: "($reviewCount)"),
                ],
              ),
            )
          ],
        ),

        /// Share Button
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Iconsax.share,
            size: TSizes.md,
          ),
        ),
      ],
    );
  }
}
