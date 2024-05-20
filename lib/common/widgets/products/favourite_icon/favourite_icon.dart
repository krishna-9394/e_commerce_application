import 'package:e_commerce_application/common/widgets/icon/t_circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TFavouriteIcons extends StatelessWidget {
  const TFavouriteIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const TCircularIcon(
      icon: Iconsax.heart5,
      color: Colors.red,
    );
  }
}
