import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.child});

  final Widget child;

  static const _tabs = ['byAuthor', 'byTitle', 'profile'];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/byTitle')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (index) => context.goNamed(_tabs[index]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'By Author',
          ),
          NavigationDestination(
            icon: Icon(Icons.text_fields),
            label: 'By Title',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
