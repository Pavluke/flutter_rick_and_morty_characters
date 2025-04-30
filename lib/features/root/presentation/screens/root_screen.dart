import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty_characters/core/app_router/app_router.dart';

@RoutePage()
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Characters'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    ];

    return AutoTabsScaffold(
      appBarBuilder:
          (context, tabsRouter) => AppBar(
            title: Text(items.elementAt(tabsRouter.activeIndex).label ?? ''),
            actions: [
              IconButton(
                onPressed: () => context.pushRoute(SettingsRoute()),
                icon: Icon(Icons.settings),
              ),
            ],
          ),
      bottomNavigationBuilder:
          (context, tabsRouter) => BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: items,
          ),
    );
  }
}
