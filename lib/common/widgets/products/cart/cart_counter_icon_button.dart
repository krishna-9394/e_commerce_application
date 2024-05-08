import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIconButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  const TCartCounterIconButton({
    super.key,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Iconsax.shopping_bag,
            color: color,
          ),
        ),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: TColors.black,
              ),
              child: Center(
                  child: Text(
                '2',
                style: Theme.of(context).textTheme.labelLarge!.apply(
                      fontSizeFactor: 0.8,
                      color: Colors.white,
                    ),
              )),
            ))
      ],
    );
  }
}
