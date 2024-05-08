import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  Rx<int> carouselCurrentIndex = 0.obs;
  final pageController = PageController();

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }
}
