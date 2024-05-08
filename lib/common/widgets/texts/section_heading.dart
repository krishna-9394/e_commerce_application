import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  final bool showActionButton;
  final String? buttonTitle;
  final String title;
  final Color? textColor;
  final void Function()? onPressed;
  const TSectionHeading({
    super.key,
    this.showActionButton = true,
    this.buttonTitle = 'view all',
    required this.title,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle!)),
      ],
    );
  }
}
