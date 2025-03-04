

# Shell Route Transitions

A Flutter package that provides beautiful and customizable transitions for shell routes in Flutter applications. This package makes it easy to add professional-looking animations when navigating between routes.

## Features

- **Multiple Animation Types**: Choose from several pre-built animations:
  - Fade transitions
  - Horizontal slide transitions
  - Vertical slide transitions
  - Scale transitions
- **Customizable**: Create your own custom transitions
- **Easy Integration**: Simple to use with Go Router or other navigation solutions
- **Performant**: Optimized for smooth animations

## Getting Started

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  shell_route_transitions: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:shell_route_transitions/export.dart';

// Using a predefined transition
CustomRouteTransitionBuilder transitionBuilder = ShellRouteTransitions.fade;

// Apply to your route configuration
// Example with GoRouter:
GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ShellScaffold(
          transitionBuilder: (context, index, child) {
            return ShellRouteTransitions.fade(
              index: index,
              child: child,
              currentIndex: _currentIndex,
              nextIndex: _nextIndex,
              animation: animation,
            );
          },
          child: child,
        );
      },
      // Additional route configuration
    ),
  ],
)
```

### Available Transitions

```dart
// Fade transition
ShellRouteTransitions.fade

// Horizontal slide transition
ShellRouteTransitions.slideHorizontal

// Vertical slide transition
ShellRouteTransitions.slideVertical

// Scale transition
ShellRouteTransitions.scale
```

### Creating Custom Transitions

You can create your own custom transitions by implementing the `CustomRouteTransitionBuilder` function type:

```dart
CustomRouteTransitionBuilder myCustomTransition = ({
  required int index,
  required Widget child,
  required int currentIndex,
  required int nextIndex,
  required Animation<double> animation,
}) {
  // Implement your custom transition logic here
  return YourCustomAnimatedWidget(
    animation: animation,
    child: child,
  );
};

// Or use the helper method
CustomRouteTransitionBuilder customTransition = ShellRouteTransitions.createCustomTransition(
  ({
    required int index,
    required Widget child,
    required int currentIndex,
    required int nextIndex,
    required Animation<double> animation,
  }) {
    // Your custom transition implementation
    return YourCustomWidget();
  },
);
```

## Example

For a complete example of how to use this package, see the `/example` folder in the GitHub repository.

## Additional Information

- [GitHub Repository](https://github.com/BawarX/shelll_route_animation)
- [Bug Reports and Feature Requests](https://github.com/BawarX/shelll_route_animation/issues)
- [API Documentation](https://pub.dev/documentation/shell_route_transitions/latest/)
