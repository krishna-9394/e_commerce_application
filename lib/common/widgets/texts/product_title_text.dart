import 'package:flutter/material.dart';

class TProductTitleText extends StatelessWidget {
  final bool smallSize;
  final String title;
  final int maxline;
  final TextAlign? align;
  const TProductTitleText({
    super.key,
    this.smallSize = false,
    required this.title,
    this.maxline = 2,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge!.apply(overflow: TextOverflow.ellipsis)
          : Theme.of(context).textTheme.titleSmall!.apply(overflow: TextOverflow.ellipsis),
      overflow: TextOverflow.ellipsis,
      maxLines: maxline,
      textAlign: align,
    );
  }
}
