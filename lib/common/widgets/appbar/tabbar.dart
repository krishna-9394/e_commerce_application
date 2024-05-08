import 'package:e_commerce_application/utils/constants/colors.dart';
import 'package:e_commerce_application/utils/device/device_utility.dart';
import 'package:e_commerce_application/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  const TTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Material(
      color: isDark ? TColors.black : TColors.primary,
      child: TabBar(
        isScrollable: true,
        indicatorColor: TColors.primary,
        labelColor: isDark ? Colors.white : TColors.grey,
        tabs: tabs,
        unselectedLabelColor: TColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
