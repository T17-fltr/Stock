import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/data_binding.dart';
import 'utils/app_colors.dart';
import 'utils/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.darkBackground,
        fontFamily: "Poppins",
      ),
      initialRoute: '/home',
      initialBinding: DataBinding(),
      getPages: appScreens,
    );
  }
}
