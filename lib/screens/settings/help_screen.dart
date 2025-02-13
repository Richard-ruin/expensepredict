// lib/screens/settings/help_screen.dart
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan'),
        backgroundColor: AppColors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHelpSection(
            'Panduan Penggunaan',
            [
              _buildHelpItem(
                'Menambah Pengeluaran',
                'Tekan tombol + di navigasi bawah untuk menambah pengeluaran baru. Isi nominal, pilih kategori, dan tambahkan catatan jika diperlukan.',
                Icons.add_circle_outline,
              ),
              _buildHelpItem(
                'Melihat Prediksi',
                'Buka tab Prediksi untuk melihat prediksi pengeluaran minggu depan berdasarkan pola pengeluaran Anda.',
                Icons.trending_up,
              ),
              _buildHelpItem(
                'Mengatur Kategori',
                'Buka Pengaturan > Kategori Pengeluaran untuk menambah, mengedit, atau menghapus kategori pengeluaran.',
                Icons.category_outlined,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFAQSection(),
          const SizedBox(height: 16),
          _buildContactSupport(),
        ],
      ),
    );
  }

  Widget _buildHelpSection(String title, List<Widget> items) {
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
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.teal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return const ListTile(
                title: Text(
                  'FAQ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
              );
            },
            body: Column(
              children: [
                _buildFAQItem(
                  'Bagaimana cara backup data?',
                  'Buka Pengaturan > Backup Data dan ikuti instruksi yang ada. Data akan disimpan secara aman di perangkat Anda.',
                ),
                _buildFAQItem(
                  'Apakah data saya aman?',
                  'Ya, semua data disimpan secara lokal di perangkat Anda. Kami tidak menyimpan data pribadi Anda di server.',
                ),
                _buildFAQItem(
                  'Bagaimana cara menghapus data?',
                  'Buka Pengaturan > Data & Privasi > Hapus Data untuk menghapus semua data aplikasi.',
                ),
              ],
            ),
            isExpanded: true,
            canTapOnHeader: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: TextStyle(
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }

  Widget _buildContactSupport() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Butuh Bantuan Lain?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.email_outlined, color: AppColors.teal),
              ),
              title: const Text('Hubungi Support'),
              subtitle: const Text('Kirim email ke support@expensepredict.com'),
              onTap: () {
                // Handle email support
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.chat_bubble_outline, color: AppColors.teal),
              ),
              title: const Text('Live Chat'),
              subtitle: const Text('Chat dengan tim support kami'),
              onTap: () {
                // Handle live chat
              },
            ),
          ],
        ),
      ),
    );
  }
}
