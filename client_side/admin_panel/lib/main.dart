import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/data/data_provider.dart';
import 'core/routes/app_pages.dart';
import 'screens/brands/provider/brand_provider.dart';
import 'screens/category/provider/category_provider.dart';
import 'screens/coupon_code/provider/coupon_code_provider.dart';
import 'screens/dashboard/provider/dash_board_provider.dart';
import 'screens/main/main_screen.dart';
import 'screens/main/provider/main_screen_provider.dart';
import 'screens/notification/provider/notification_provider.dart';
import 'screens/order/provider/order_provider.dart';
import 'screens/posters/provider/poster_provider.dart';
import 'screens/sub_category/provider/sub_category_provider.dart';
import 'screens/variants/provider/variant_provider.dart';
import 'screens/variants_type/provider/variant_type_provider.dart';
import 'utility/constants.dart';
import 'utility/extensions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => MainScreenProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CategoryProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => SubCategoryProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => BrandProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => VariantsTypeProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => VariantsProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => DashBoardProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => CouponCodeProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => PosterProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => OrderProvider(context.dataProvider),
    ),
    ChangeNotifierProvider(
      create: (context) => NotificationProvider(context.dataProvider),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: AppPages.HOME,
      unknownRoute: GetPage(name: '/notFound', page: () => MainScreen()),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    );
  }
}
