import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shell_route_transitions/shell_route_transitions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shell Route Transitions Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// Example pages
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final StatefulNavigationShell navigationShell =
                    context
                        .findAncestorWidgetOfExactType<
                          StatefulNavigationShell
                        >()!;
                navigationShell.goBranch(1);
              },
              child: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screen', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final StatefulNavigationShell navigationShell =
                    context
                        .findAncestorWidgetOfExactType<
                          StatefulNavigationShell
                        >()!;
                navigationShell.goBranch(2);
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Screen', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final StatefulNavigationShell navigationShell =
                    context
                        .findAncestorWidgetOfExactType<
                          StatefulNavigationShell
                        >()!;
                navigationShell.goBranch(0);
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigation setup with shell route transitions
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AnimatedShellRouteContainer(
          navigationShell: navigationShell,
          transitionBuilder: ShellRouteTransitions.fade,
          children: [
            const HomeScreen(),
            const ProfileScreen(),
            const SettingsScreen(),
          ],
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (_, __) => const SizedBox.shrink()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    ),
  ],
);
