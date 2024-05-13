import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  final String currencySign, price;
  final int maxLine;
  final bool isLarge, lineThrough, isSmall;

  const TProductPriceText({
    super.key,
    this.currencySign = '\u{20B9}',
    required this.price,
    this.maxLine = 1,
    this.isLarge = false,
    this.isSmall = false,
    this.lineThrough = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? (Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null))
          : isSmall
              ? (Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null))
              : (Theme.of(context).textTheme.titleLarge!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null)),
    );
  }
}
