import 'package:flutter/material.dart';
import 'package:stocks_app_main/utils/app_colors.dart';
import 'package:iconsax/iconsax.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: const Text("My Card"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 💳 Card UI
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3B5185),
                    Color(0xFF1A2849),
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Balance", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 10),
                    Text(
                      "\$24,109.10",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "**** **** **** 1298",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ⚡ Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _Action(icon: Iconsax.send_2, label: "Send"),
                _Action(icon: Iconsax.receive_square, label: "Receive"),
                _Action(icon: Iconsax.add, label: "Add"),
              ],
            ),

            const SizedBox(height: 30),

            // 🧾 Recent Transactions
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Activity",
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const _TransactionTile(
              title: "Netflix",
              amount: "-\$15.99",
            ),
            const _TransactionTile(
              title: "Salary",
              amount: "+\$2,000",
            ),
            const _TransactionTile(
              title: "Amazon",
              amount: "-\$120.50",
            ),
          ],
        ),
      ),
    );
  }
}

// reusable widgets
class _Action extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Action({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.cardDarkBackground,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String title;
  final String amount;

  const _TransactionTile({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Text(amount, style: const TextStyle(color: Colors.white)),
    );
  }
}