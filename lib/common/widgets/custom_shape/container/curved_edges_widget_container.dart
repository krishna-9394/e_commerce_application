import 'package:e_commerce_application/common/widgets/custom_shape/container/circular_container.dart';
import 'package:e_commerce_application/common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryCurvedEdgesWidget extends StatelessWidget {
  const TPrimaryCurvedEdgesWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                color: TColors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                color: TColors.white.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
