// lib/screens/predictions/prediction_summary.dart
import 'package:flutter/material.dart';
import 'package:expensepredict/constants/colors.dart';
class PredictionSummary extends StatelessWidget {
  const PredictionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPredictionCard(
          title: 'Prediksi Minggu Depan',
          amount: 'Rp 2.500.000',
          trend: 0.05,
          isIncrease: true,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInsightCard(
                title: 'Pengeluaran Tertinggi',
                category: 'Makanan',
                amount: 'Rp 800.000',
                icon: Icons.restaurant,
                color: AppColors.softRed,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInsightCard(
                title: 'Kategori Terbanyak',
                category: 'Transport',
                amount: '15 transaksi',
                icon: Icons.directions_car,
                color: AppColors.warmOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPredictionCard({
    required String title,
    required String amount,
    required double trend,
    required bool isIncrease,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkBlue,
                )),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      isIncrease
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: isIncrease ? AppColors.softRed : AppColors.teal,
                      size: 16,
                    ),
                    Text(
                      '${(trend * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: isIncrease ? AppColors.softRed : AppColors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String category,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          )),
                      Text(amount,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}