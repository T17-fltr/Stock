import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stocks_app_main/models/stock.dart';
import 'package:stocks_app_main/utils/app_colors.dart';

class StockDisplay extends StatelessWidget {
  const StockDisplay({
    super.key,
    required this.name,
    required this.symbol,
    required this.isUp,
    required this.stockData,
  });

  final String name;
  final String symbol;
  final bool isUp;

  // live API data
  final Rx<AlphaVantageDailyResponse> stockData;

  @override
  Widget build(BuildContext context) {
    final lineColor = isUp ? const Color(0xFF4CAF50) : const Color(0xFFE53935);

    return Container(
      width: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardDarkBackground.withAlpha(220),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            symbol,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 55,
            child: _MiniLineChart(
              stockData: stockData,
              lineColor: lineColor,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "\$523.11",
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            isUp ? "+12%" : "-12%",
            style: TextStyle(
              color: lineColor,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniLineChart extends StatelessWidget {
  const _MiniLineChart({
    required this.stockData,
    required this.lineColor,
  });

  final Rx<AlphaVantageDailyResponse> stockData;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bars = stockData.value.bars;
      if (bars.isEmpty) {
        return const SizedBox.shrink();
      }

      // Use the last 20 points (or less if not available)
      final takeCount = bars.length >= 20 ? 20 : bars.length;

      // bars are sorted newest -> oldest in your model, so reverse to oldest -> newest
      final latest = bars.take(takeCount).toList().reversed.toList();

      final spots = <FlSpot>[];
      for (int i = 0; i < latest.length; i++) {
        spots.add(FlSpot(i.toDouble(), latest[i].close));
      }

      double minY = spots.first.y;
      double maxY = spots.first.y;
      for (final s in spots) {
        if (s.y < minY) minY = s.y;
        if (s.y > maxY) maxY = s.y;
      }

      // give a tiny padding so the line isn't glued to the edges
      final padding = (maxY - minY) == 0 ? 1.0 : (maxY - minY) * 0.10;

      return LineChart(
        LineChartData(
          minX: 0,
          maxX: (spots.length - 1).toDouble(),
          minY: minY - padding,
          maxY: maxY + padding,
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: lineColor,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      );
    });
  }
}
