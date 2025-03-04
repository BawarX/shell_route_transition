import 'package:flutter/material.dart';

enum AnimationType { fade, slideHorizontal, slideVertical, scale }

typedef CustomRouteTransitionBuilder =
Widget Function({
required int index,
required Widget child,
required int currentIndex,
required int nextIndex,
required Animation<double> animation,
});

class ShellRouteTransitions {
  static CustomRouteTransitionBuilder get fade => _fadeTransition;
  static CustomRouteTransitionBuilder get slideHorizontal =>
      _slideHorizontalTransition;
  static CustomRouteTransitionBuilder get slideVertical =>
      _slideVerticalTransition;
  static CustomRouteTransitionBuilder get scale => _scaleTransition;

  static Widget _fadeTransition({
    required int index,
    required Widget child,
    required int currentIndex,
    required int nextIndex,
    required Animation<double> animation,
  }) {
    double opacity = 0.0;

    if (index == currentIndex && index != nextIndex) {
      opacity = 1.0 - animation.value;
    } else if (index == nextIndex) {
      opacity = animation.value;
    } else if (index == currentIndex && index == nextIndex) {
      opacity = 1.0;
    }

    return Positioned.fill(child: Opacity(opacity: opacity, child: child));
  }

  static Widget _slideHorizontalTransition({
    required int index,
    required Widget child,
    required int currentIndex,
    required int nextIndex,
    required Animation<double> animation,
  }) {
    double offsetX = 0.0;
    double opacity = 0.0;
    bool isMovingForward = nextIndex > currentIndex;

    if (index == currentIndex && index != nextIndex) {
      offsetX = isMovingForward ? -animation.value : animation.value;
      opacity = 1.0 - animation.value;
    } else if (index == nextIndex) {
      offsetX =
      isMovingForward ? 1.0 - animation.value : -1.0 + animation.value;
      opacity = animation.value;
    } else if (index == currentIndex && index == nextIndex) {
      offsetX = 0.0;
      opacity = 1.0;
    }

    return Positioned.fill(
      child: FractionalTranslation(
        translation: Offset(offsetX, 0.0),
        child: Opacity(opacity: opacity, child: child),
      ),
    );
  }

  static Widget _slideVerticalTransition({
    required int index,
    required Widget child,
    required int currentIndex,
    required int nextIndex,
    required Animation<double> animation,
  }) {
    double offsetY = 0.0;
    double opacity = 0.0;

    if (index == currentIndex && index != nextIndex) {
      offsetY = -animation.value;
      opacity = 1.0 - animation.value;
    } else if (index == nextIndex) {
      offsetY = 1.0 - animation.value;
      opacity = animation.value;
    } else if (index == currentIndex && index == nextIndex) {
      offsetY = 0.0;
      opacity = 1.0;
    }

    return Positioned.fill(
      child: FractionalTranslation(
        translation: Offset(0.0, offsetY),
        child: Opacity(opacity: opacity, child: child),
      ),
    );
  }

  static Widget _scaleTransition({
    required int index,
    required Widget child,
    required int currentIndex,
    required int nextIndex,
    required Animation<double> animation,
  }) {
    double scale = 1.0;
    double opacity = 0.0;

    if (index == currentIndex && index != nextIndex) {
      scale = 1.0 - (0.3 * animation.value);
      opacity = 1.0 - animation.value;
    } else if (index == nextIndex) {
      scale = 0.7 + (0.3 * animation.value);
      opacity = animation.value;
    } else if (index == currentIndex && index == nextIndex) {
      scale = 1.0;
      opacity = 1.0;
    }

    return Positioned.fill(
      child: Transform.scale(
        scale: scale,
        child: Opacity(opacity: opacity, child: child),
      ),
    );
  }

  static CustomRouteTransitionBuilder createCustomTransition(
      CustomRouteTransitionBuilder builder,
      ) {
    return builder;
  }
}
