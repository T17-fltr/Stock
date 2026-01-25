import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';
import '../utils/app_colors.dart';

class Transactions extends StatelessWidget {
  const Transactions({
    super.key,
    required this.stockIcon,
    required this.stockName,
    required this.stockSymbol,
    required this.stockData,
  });

  final String stockIcon;
  final String stockName;
  final String stockSymbol;

  // This is the Rx<AlphaVantageDailyResponse> from the controller
  final Rx stockData;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DataController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: Obx(() {
        final closeText = controller.closeText(stockData as dynamic);
        final pct = controller.latestPercentChange(stockData as dynamic);
        final pctText = controller.percentText(stockData as dynamic);

        final pctColor =
            pct >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFE53935);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryText,
                    border: Border.all(color: AppColors.borderLight, width: 1),
                  ),
                  child: ClipOval(
                    child: Image.asset(stockIcon, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stockName,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      stockSymbol,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  closeText,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Text(
                  pctText,
                  style: TextStyle(
                    color: pctColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
