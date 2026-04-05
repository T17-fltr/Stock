import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import 'package:stocks_app_main/utils/app_colors.dart';
import 'package:stocks_app_main/screens/card_screen.dart';
import 'package:stocks_app_main/screens/analytics_screen.dart';
import 'package:stocks_app_main/screens/profile_screen.dart';

// keep your original home content widgets
import 'package:stocks_app_main/widgets/balance_display.dart';
import 'package:stocks_app_main/widgets/custom_app_bar.dart';
import 'package:stocks_app_main/widgets/transaction_button.dart';
import 'package:stocks_app_main/widgets/transactions.dart';
import 'package:get/get.dart';
import 'package:stocks_app_main/controllers/data_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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

        // ✅ PAGE VIEW (THE Paginator)
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            _buildHomePage(),        // index 0
            const CardScreen(),     // index 1
            const AnalyticsScreen(),// index 2
            const ProfileScreen(),  // index 3
          ],
        ),

        // ✅ BOTTOM NAV CONTROLS PAGE SWITCHING
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
          elevation: 0.5,
          selectedItemColor: AppColors.contentColorBlue,
          unselectedItemColor: AppColors.primaryText,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.card),
              label: "Card",
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.graph),
              label: "Analytics",
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  // ✅ YOUR ORIGINAL HOME UI (JUST MOVED INTO A METHOD)
  Widget _buildHomePage() {
    return SafeArea(
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
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                Text(
                  "Live data connected ✅",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "My portfolio",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "View all",
                  style: TextStyle(color: AppColors.primaryText),
                ),
              ],
            ),
          ),

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
    );
  }
}