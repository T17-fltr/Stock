import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../models/stock.dart';

class DataController extends GetxController {
  Rx<AlphaVantageDailyResponse> appleStock =
      AlphaVantageDailyResponse.fromEmpty().obs;
  Rx<AlphaVantageDailyResponse> googleStock =
      AlphaVantageDailyResponse.fromEmpty().obs;
  Rx<AlphaVantageDailyResponse> amazonStock =
      AlphaVantageDailyResponse.fromEmpty().obs;

  @override
  void onInit() {
    super.onInit();
    getStockPrices();
  }

  Future<void> getStockPrices() async {
    var aaplStock = await RemoteServices.getStockPrices("AAPL");
    appleStock(aaplStock);

    Future.delayed(const Duration(seconds: 2), () async {
      var googlStock = await RemoteServices.getStockPrices("GOOGL");
      googleStock(googlStock);
    });

    Future.delayed(const Duration(seconds: 6), () async {
      var amznStock = await RemoteServices.getStockPrices("AMZN");
      amazonStock(amznStock);
    });
  }

  // ---------- REQUIRED FOR THIS WEEK'S ASSIGNMENT ----------

  // 1) Stock price should be the CLOSE of the latest DailyBar
  double latestClose(Rx<AlphaVantageDailyResponse> stock) {
    final bars = stock.value.bars;
    if (bars.isEmpty) return 0.0;
    return bars.first.close;
  }

  // 2) % change should be based on OPEN and CLOSE of the latest DailyBar
  double latestPercentChange(Rx<AlphaVantageDailyResponse> stock) {
    final bars = stock.value.bars;
    if (bars.isEmpty) return 0.0;

    final open = bars.first.open;
    final close = bars.first.close;

    if (open == 0) return 0.0;

    return ((close - open) / open) * 100;
  }

  String closeText(Rx<AlphaVantageDailyResponse> stock) {
    final close = latestClose(stock);
    if (close == 0) return "--";
    return "\$${close.toStringAsFixed(2)}";
  }

  String percentText(Rx<AlphaVantageDailyResponse> stock) {
    final pct = latestPercentChange(stock);
    if (pct == 0) return "--";
    final sign = pct >= 0 ? "+" : "";
    return "$sign${pct.toStringAsFixed(2)}%";
  }
}

class RemoteServices {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: "https://www.alphavantage.co"),
  );

  static Future<AlphaVantageDailyResponse> getStockPrices(String symbol) async {
    Response response = await dio.get(
      "/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=VRPSSNJICLSJMM08",
    );

    return AlphaVantageDailyResponse.fromJson(
      (response.data as Map).cast<String, dynamic>(),
    );
  }
}
