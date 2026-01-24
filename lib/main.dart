import 'package:flutter/material.dart';
import 'package:stocks_app-main/bindings/data_binding.dart';
import 'package:stocks_app-main/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:stocks_app-main/utils/router.dart';

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