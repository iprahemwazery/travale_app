import 'package:flutter/material.dart';
import 'package:travale_app/auth/login/login_view.dart';
import 'package:travale_app/core/network/api_service.dart';
import 'package:travale_app/core/network/pref_helper.dart';
import 'package:travale_app/features/profile/models/user_models.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: FutureBuilder<User?>(
        future: apiService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Failed to load profile'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Gradient + Avatar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            user.avatarUrl.isNotEmpty
                                ? NetworkImage(user.avatarUrl)
                                : null,
                        child:
                            user.avatarUrl.isEmpty
                                ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.grey[700],
                                )
                                : null,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.name.isNotEmpty ? user.name : user.username,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email.isNotEmpty
                            ? user.email
                            : 'No email available',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Options List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      profileOption(Icons.edit, 'Edit Profile', onTap: () {}),
                      const SizedBox(height: 16),
                      profileOption(Icons.settings, 'Settings', onTap: () {}),
                      const SizedBox(height: 16),
                      profileOption(
                        Icons.notifications,
                        'Notifications',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      profileOption(
                        Icons.help_outline,
                        'Help & Support',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      profileOption(
                        Icons.logout,
                        'Logout',
                        onTap: () => _showLogoutDialog(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// -----------------------------
  /// Dialog لتأكيد Logout ومسح التوكن
  /// -----------------------------
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  await PrefHelper.clearToken();
                  Navigator.of(ctx).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                  );
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }

  /// -----------------------------
  /// Widget لكل خيار في الصفحة
  /// -----------------------------
  Widget profileOption(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
