import 'package:get/get.dart';
import 'package:stocks_app_main/bindings/data_binding.dart';
import 'package:stocks_app_main/screens/home_screen.dart';
import 'package:stocks_app_main/screens/card_screen.dart';
import 'package:stocks_app_main/screens/analytics_screen.dart';
import 'package:stocks_app_main/screens/profile_screen.dart';

final List<GetPage> appScreens = [
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    bindings: [DataBinding()],
  ),
  GetPage(
    name: '/card',
    page: () => const CardScreen(),
  ),
  GetPage(
    name: '/analytics',
    page: () => const AnalyticsScreen(),
  ),
  GetPage(
    name: '/profile',
    page: () => const ProfileScreen(),
  ),
];
