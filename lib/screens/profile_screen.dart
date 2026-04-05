import 'package:flutter/material.dart';
import 'package:stocks_app_main/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/user.png"),
            ),

            const SizedBox(height: 10),

            const Text(
              "Tobi Bamidele",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 18,
              ),
            ),

            const Text(
              "tobi@email.com",
              style: TextStyle(color: Colors.white54),
            ),

            const SizedBox(height: 30),

            const _ProfileOption(title: "Edit Profile"),
            const _ProfileOption(title: "Settings"),
            const _ProfileOption(title: "Notifications"),
            const _ProfileOption(title: "Logout"),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final String title;

  const _ProfileOption({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
    );
  }
}