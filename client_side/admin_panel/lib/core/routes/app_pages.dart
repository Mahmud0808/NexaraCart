import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../screens/main/main_screen.dart';

class AppPages {
  static const HOME = '/';

  static final routes = [
    GetPage(name: HOME, fullscreenDialog: true, page: () => MainScreen()),
  ];
}
