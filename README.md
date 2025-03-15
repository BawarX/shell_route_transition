# Shell Route Transitions

A Flutter package that provides beautiful and customizable transitions for shell routes in Flutter applications. This package makes it easy to add professional-looking animations when navigating between routes.

![Package Demo](assets/gifs/demo.gif)

## Features

- **Multiple Animation Types**: Choose from several pre-built animations:
  - Fade transitions
  - Horizontal slide transitions
  - Vertical slide transitions
  - Scale transitions
- **Customizable**: Create your own custom transitions
- **Easy Integration**: Simple to use with Go Router or other navigation solutions
- **Performant**: Optimized for smooth animations

## Transition Types

### Fade Transition
![Fade Transition](assets/gifs/fade_transition.gif)

### Horizontal Slide Transition
![Horizontal Slide](assets/gifs/slide_horizontal_transition.gif)

### Vertical Slide Transition
![Vertical Slide](assets/gifs/slide_vertical.gif)

### Scale Transition
![Scale Transition](assets/gifs/scale_transition.gif)


## Getting Started

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  shell_route_transitions: ^0.0.7
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
final goRouter = GoRouter(
  initialLocation: '/a',

  debugLogDiagnostics: true,
  routes: [
    AnimatedStatefulShellRoute(
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: ShellRouteTransitions.scale,
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/a',
              builder:
                  (context, state) =>
                      const RootScreen(label: 'A', detailsPath: '/a/details'),
            ),
          ],
        ),
        .....
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




## Additional Information

- [GitHub Repository](https://github.com/BawarX/shelll_route_animation)
- [Bug Reports and Feature Requests](https://github.com/BawarX/shelll_route_animation/issues)
- [API Documentation](https://pub.dev/documentation/shell_route_transitions/latest/)
