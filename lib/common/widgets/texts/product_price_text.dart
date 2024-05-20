import 'package:flutter/material.dart';

class TProductPriceText extends StatelessWidget {
  final String price;
  final int maxLine;
  final bool isLarge, lineThrough, isSmall;
  final bool addCurrencySymbol;

  const TProductPriceText({
    super.key,
    required this.price,
    this.maxLine = 1,
    this.isLarge = false,
    this.isSmall = false,
    this.lineThrough = false,
    this.addCurrencySymbol = false,
  });

  @override
  Widget build(BuildContext context) {
    const String currencySign = '\u{20B9}';
    return Text(
      addCurrencySymbol ? '$currencySign $price' : price,
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
