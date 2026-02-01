import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import 'package:stocks_app_main/controllers/data_controller.dart';
import 'package:stocks_app_main/utils/app_colors.dart';
import 'package:stocks_app_main/widgets/balance_display.dart';
import 'package:stocks_app_main/widgets/custom_app_bar.dart';
import 'package:stocks_app_main/widgets/line_chart.dart';
import 'package:stocks_app_main/widgets/transaction_button.dart';
import 'package:stocks_app_main/widgets/transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataController _controller = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    _controller.getStockPrices();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.darkBackground,
        systemNavigationBarColor: AppColors.navBarBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const BalanceDisplay(),
              const TransactionButtonRow(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Featured investment",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      StockDisplay(
                        name: "Apple",
                        symbol: "AAPL",
                        isUp: true,
                        stockData: _controller.appleStock,
                      ),
                      const SizedBox(width: 8),
                      StockDisplay(
                        name: "Google",
                        symbol: "GOOGL",
                        isUp: false,
                        stockData: _controller.googleStock,
                      ),
                      const SizedBox(width: 8),
                      StockDisplay(
                        name: "Amazon",
                        symbol: "AMZN",
                        isUp: true,
                        stockData: _controller.amazonStock,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My portfolio",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    InkWell(
                      child: const Text(
                        "View all",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ LIVE DATA rows (uses your actual asset names)
              Transactions(
                stockIcon: "assets/images/appl_icon.png",
                stockName: "Apple",
                stockSymbol: "AAPL",
                stockData: _controller.appleStock,
              ),
              Transactions(
                stockIcon: "assets/images/googl_icon.png",
                stockName: "Google",
                stockSymbol: "GOOGL",
                stockData: _controller.googleStock,
              ),
              Transactions(
                stockIcon: "assets/images/amz_icon.png",
                stockName: "Amazon",
                stockSymbol: "AMZN",
                stockData: _controller.amazonStock,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.5,
          selectedItemColor: AppColors.contentColorBlue,
          unselectedItemColor: AppColors.primaryText,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: "Home",
              backgroundColor: AppColors.navBarBackground,
            ),
            BottomNavigationBarItem(icon: Icon(Iconsax.card), label: "Card"),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.graph),
              label: "Analytics",
            ),
            BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
