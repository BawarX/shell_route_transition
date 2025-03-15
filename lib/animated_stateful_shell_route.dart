import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shell_route_transitions/route_transition.dart';
import 'package:collection/collection.dart';

class AnimatedShellRouteContainer extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final CustomRouteTransitionBuilder transitionBuilder;

  const AnimatedShellRouteContainer({
    super.key,
    required this.navigationShell,
    required this.children,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionCurve = Curves.easeInOut,
    required this.transitionBuilder,
  });

  @override
  State<AnimatedShellRouteContainer> createState() =>
      _AnimatedShellRouteContainerState();
}

class _AnimatedShellRouteContainerState
    extends State<AnimatedShellRouteContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _currentIndex = 0;
  int _nextIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.navigationShell.currentIndex;
    _nextIndex = _currentIndex;

    _animationController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    )..value = 1.0;

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.transitionCurve,
    );
  }

  @override
  void didUpdateWidget(AnimatedShellRouteContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.navigationShell.currentIndex !=
        widget.navigationShell.currentIndex) {
      _onBranchChanged(widget.navigationShell.currentIndex);
    }
  }

  /// Handles branch (tab) changes with animation
  /// Includes protection against rapid tab switching desynchronization
  void _onBranchChanged(int newIndex) {
    if (_currentIndex == newIndex) return;

    // Store the new index as the target destination
    _nextIndex = newIndex;

    // Handle interruption of animations when rapidly switching tabs
    if (_animationController.isAnimating) {
      _animationController.stop();

      // If animation was more than halfway through, consider the previous animation
      // as effectively completed for better visual feedback during rapid switching
      if (_animationController.value > 0.5) {
        _currentIndex = _nextIndex;
        _nextIndex = newIndex;
      }
    }

    _animationController.reset();

    // Begin the animation to the new tab
    _animationController.forward().then((_) {
      // Only update state if this completion callback is for the most recent animation
      // and if the widget is still mounted - prevents stale animation callbacks
      if (mounted && _nextIndex == newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Safety mechanism: ensure UI state remains synchronized with the navigation shell
    // This prevents the desynchronization when rapidly switching tabs
    if (!_animationController.isAnimating &&
        widget.navigationShell.currentIndex != _currentIndex) {
      // Force synchronization if we detect a mismatch between UI and logical state
      _currentIndex = widget.navigationShell.currentIndex;
      _nextIndex = _currentIndex;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          child: Stack(
            children:
                widget.children.mapIndexed<Widget>((index, child) {
                  final bool isVisible =
                      index == _currentIndex || index == _nextIndex;

                  Widget animatedChild = _createAnimatedChild(
                    child,
                    index,
                    isVisible,
                  );

                  return widget.transitionBuilder(
                    index: index,
                    child: animatedChild,
                    currentIndex: _currentIndex,
                    nextIndex: _nextIndex,
                    animation: _animation,
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Widget _createAnimatedChild(Widget child, int index, bool isVisible) {
    // Determine if this child should be interactive based on animation state
    bool shouldIgnorePointer;

    if (_animationController.isAnimating) {
      // During animation, only the target tab should be interactive
      shouldIgnorePointer = index != _nextIndex;
    } else {
      // When no animation is happening, only the current tab should be interactive
      shouldIgnorePointer = index != _currentIndex;
    }

    return TickerMode(
      enabled: isVisible,
      child: IgnorePointer(ignoring: shouldIgnorePointer, child: child),
    );
  }
}

class AnimatedStatefulShellRoute extends StatefulShellRoute {
  AnimatedStatefulShellRoute({
    required super.branches,
    required StatefulShellRouteBuilder super.builder,
    super.redirect,
    super.parentNavigatorKey,
    super.pageBuilder,
    super.restorationScopeId,
    GlobalKey<StatefulNavigationShellState>? navigatorKey,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionCurve = Curves.easeInOut,
    required this.transitionBuilder,
  }) : super(
         navigatorContainerBuilder: _buildAnimatedContainer,
         key: navigatorKey,
       );

  final Duration transitionDuration;
  final Curve transitionCurve;
  final CustomRouteTransitionBuilder transitionBuilder;

  static Widget _buildAnimatedContainer(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    final AnimatedStatefulShellRoute route =
        navigationShell.route as AnimatedStatefulShellRoute;

    return AnimatedShellRouteContainer(
      navigationShell: navigationShell,
      transitionDuration: route.transitionDuration,
      transitionCurve: route.transitionCurve,
      transitionBuilder: route.transitionBuilder,
      children: children,
    );
  }
}
