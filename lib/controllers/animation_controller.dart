import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  Animation<Offset> get slideAnimation => _slideAnimation;
  bool get hasAnimated => _hasAnimated;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }

  void startAnimation() {
    if (!_hasAnimated) {
      _hasAnimated = true;
      update();
      _animationController.forward();
    }
  }

  void checkScrollTrigger(double scrollPosition, double triggerPoint) {
    if (scrollPosition >= triggerPoint) {
      startAnimation();
    }
  }
}
