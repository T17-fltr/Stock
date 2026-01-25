import 'package:get/get.dart';
import 'package:stocks_app_main/bindings/data_binding.dart';
import 'package:stocks_app_main/screens/home_screen.dart';

final List<GetPage> appScreens = [
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    bindings: [DataBinding()],
  ),
];