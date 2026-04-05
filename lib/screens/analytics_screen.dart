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
        title: const Text("Analytics"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 📊 Summary cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _StatCard(title: "Profit", value: "+\$1,240"),
                _StatCard(title: "Loss", value: "-\$320"),
              ],
            ),

            const SizedBox(height: 20),

            // 📈 Fake chart placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.cardDarkBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "Chart goes here",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Insights",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "• Your portfolio increased by 12% this month\n"
              "• Tech stocks are performing well\n"
              "• Consider diversifying assets",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDarkBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white54)),
          const SizedBox(height: 5),
          Text(value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ],
      ),
    );
  }
}