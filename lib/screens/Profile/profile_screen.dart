import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../settings/settings_screen.dart';
import '../settings/history_screen.dart';
import '../settings/help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.teal,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'User Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'user@email.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              _buildProfileMenuItem(
                context,
                icon: Icons.settings,
                title: 'Pengaturan',
                subtitle: 'Kategori, notifikasi, dan lainnya',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                ),
              ),
              _buildProfileMenuItem(
                context,
                icon: Icons.history,
                title: 'Riwayat',
                subtitle: 'Lihat riwayat pengeluaran',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                ),
              ),
              _buildProfileMenuItem(
                context,
                icon: Icons.help,
                title: 'Bantuan',
                subtitle: 'Panduan dan FAQ',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.softRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.logout, color: AppColors.softRed),
                  ),
                  title: const Text(
                    'Keluar',
                    style: TextStyle(
                      color: AppColors.softRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, 
                    size: 16, 
                    color: AppColors.softRed,
                  ),
                  onTap: () {
                    // Show logout confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Keluar'),
                        content: const Text(
                          'Apakah Anda yakin ingin keluar dari aplikasi?'
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.softRed,
                            ),
                            onPressed: () {
                              // Handle logout
                              Navigator.pop(context);
                            },
                            child: const Text('Keluar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.teal),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.darkBlue,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}