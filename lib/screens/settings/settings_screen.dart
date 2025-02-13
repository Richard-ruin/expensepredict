// lib/screens/settings/settings_screen.dart
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'category_screen.dart';
import 'history_screen.dart';
import 'help_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: AppColors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsSection(
            'Aplikasi',
            [
              _buildSettingTile(
                context,
                icon: Icons.category,
                title: 'Kategori Pengeluaran',
                subtitle: 'Atur kategori pengeluaran Anda',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryScreen()),
                ),
              ),
              _buildSettingTile(
                context,
                icon: Icons.notifications,
                title: 'Notifikasi',
                subtitle: 'Atur pengingat dan notifikasi',
                onTap: () {},
              ),
              _buildSettingTile(
                context,
                icon: Icons.language,
                title: 'Bahasa',
                subtitle: 'Pilih bahasa aplikasi',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            'Data & Privasi',
            [
              _buildSettingTile(
                context,
                icon: Icons.history,
                title: 'Riwayat',
                subtitle: 'Lihat riwayat pengeluaran',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                ),
              ),
              _buildSettingTile(
                context,
                icon: Icons.backup,
                title: 'Backup Data',
                subtitle: 'Backup dan restore data',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(
            'Lainnya',
            [
              _buildSettingTile(
                context,
                icon: Icons.help_outline,
                title: 'Bantuan',
                subtitle: 'Panduan penggunaan aplikasi',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()),
                ),
              ),
              _buildSettingTile(
                context,
                icon: Icons.info_outline,
                title: 'Tentang',
                subtitle: 'Informasi aplikasi',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.teal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.teal),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}