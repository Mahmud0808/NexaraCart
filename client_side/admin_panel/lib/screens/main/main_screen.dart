import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utility/extensions.dart';
import 'components/side_menu.dart';
import 'provider/main_screen_provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.dataProvider;
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Consumer<MainScreenProvider>(
              builder: (context, provider, child) {
                return Expanded(
                  flex: 5,
                  child: provider.selectedScreen,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
