import 'package:e_commerce_application/common/widgets/custom_shape/container/circular_container.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  const TChoiceChip({
    super.key,
    required this.text,
    this.onSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final color = THelperFunctions.getColor(text);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: THelperFunctions.getColor(text) != null
            ? const SizedBox()
            : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected == true ? TColors.white : null),
        avatar: color != null
            ? TCircularContainer(
                width: 50,
                height: 50,
                color: color,
              )
            : null,
        labelPadding: color != null ? const EdgeInsets.all(0) : null,
        padding: color != null ? const EdgeInsets.all(0) : null,
        shape: color != null ? const CircleBorder() : null,
        backgroundColor: color,
      ),
    );
  }
}
