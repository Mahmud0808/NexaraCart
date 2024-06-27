import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nexara_cart/utility/extensions.dart';

import '../../../models/user.dart';
import '../../../utility/constants.dart';
import '../../../widget/app_bar_action_button.dart';
import '../../../widget/custom_search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBarActionButton(
                icon: Icons.menu,
                onPressed: () {
                  final box = GetStorage();
                  Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
                  User? userLogged = User.fromJson(userJson ?? {});
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: CustomSearchBar(
                  controller: TextEditingController(),
                  onChanged: (val) {
                    context.dataProvider.filterProducts(val);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
