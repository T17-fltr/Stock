import 'package:flutter/material.dart';
import 'package:stocks_app_main/utils/app_colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: const Text(
          "Analytics",
          style: TextStyle(color: AppColors.primaryText),
        ),
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      body: const Center(
        child: Text(
          "Analytics Screen",
          style: TextStyle(color: AppColors.primaryText),
        ),
      ),
    );
  }
}
