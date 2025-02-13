// lib/screens/settings/history_screen.dart
import 'package:flutter/material.dart';
import 'package:expensepredict/constants/colors.dart';
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pengeluaran'),
        backgroundColor: AppColors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMonthSection('Februari 2024', [
            _buildHistoryItem(
              date: '20 Feb 2024',
              title: 'Makan Siang',
              amount: 'Rp 50.000',
              category: 'Makanan',
              icon: Icons.restaurant,
            ),
            _buildHistoryItem(
              date: '19 Feb 2024',
              title: 'Transport',
              amount: 'Rp 25.000',
              category: 'Transport',
              icon: Icons.directions_car,
            ),
          ]),
          const SizedBox(height: 16),
          _buildMonthSection('Januari 2024', [
            _buildHistoryItem(
              date: '31 Jan 2024',
              title: 'Belanja Bulanan',
              amount: 'Rp 750.000',
              category: 'Belanja',
              icon: Icons.shopping_cart,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildMonthSection(String month, List<Widget> items) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              month,
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

  Widget _buildHistoryItem({
    required String date,
    required String title,
    required String amount,
    required String category,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
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
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkBlue,
                  ),
                ),
                Text(
                  '$category • $date',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              color: AppColors.softRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
