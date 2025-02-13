// lib/screens/home/widgets/recent_transactions.dart
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        'title': 'Makan Siang',
        'date': '20 Feb 2024',
        'amount': 'Rp 50.000',
        'icon': Icons.restaurant,
        'category': 'Makanan'
      },
      {
        'title': 'Transport Gojek',
        'date': '20 Feb 2024',
        'amount': 'Rp 25.000',
        'icon': Icons.directions_car,
        'category': 'Transport'
      },
      {
        'title': 'Belanja Bulanan',
        'date': '19 Feb 2024',
        'amount': 'Rp 750.000',
        'icon': Icons.shopping_cart,
        'category': 'Belanja'
      },
      {
        'title': 'Internet',
        'date': '19 Feb 2024',
        'amount': 'Rp 350.000',
        'icon': Icons.wifi,
        'category': 'Utilitas'
      },
      {
        'title': 'Nonton Bioskop',
        'date': '18 Feb 2024',
        'amount': 'Rp 100.000',
        'icon': Icons.movie,
        'category': 'Hiburan'
      },
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transaksi Terakhir',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to all transactions
                  },
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(color: AppColors.teal),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      transaction['icon'] as IconData,
                      color: AppColors.teal,
                    ),
                  ),
                  title: Text(
                    transaction['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  subtitle: Text(
                    '${transaction['category']} • ${transaction['date']}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(
                    transaction['amount'] as String,
                    style: const TextStyle(
                      color: AppColors.softRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}