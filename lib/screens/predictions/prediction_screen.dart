import 'package:flutter/material.dart';
import 'package:expensepredict/constants/colors.dart';
import 'package:expensepredict/services/api_service.dart';
import 'widgets/prediction_chart.dart';
import 'widgets/prediction_summary.dart';
import 'package:intl/intl.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _apiService = ApiService();
  Map<String, dynamic>? _nextWeekPrediction;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrediction();
  }

  Future<void> _loadPrediction() async {
    try {
      final predictions = await _apiService.getPredictions();
      if (predictions.isNotEmpty) {
        setState(() {
          _nextWeekPrediction = predictions.last;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  String _formatAmount(double amount) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.teal,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Prediksi Pengeluaran',
                  style: TextStyle(color: Colors.white),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.teal, AppColors.darkBlue],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Prediksi Minggu Depan',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.darkBlue,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (_nextWeekPrediction != null)
                                          Text(
                                            _formatAmount(_nextWeekPrediction![
                                                    'predicted_amount']
                                                .toDouble()),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.teal,
                                            ),
                                          ),
                                      ],
                                    ),
                                    if (_nextWeekPrediction != null)
                                      _buildTrendIndicator(
                                          _nextWeekPrediction!),
                                  ],
                                ),
                        ),
                        const Divider(),
                        const PredictionChart(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const PredictionSummary(),
                  const SizedBox(height: 16),
                  _buildRecommendationsCard(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendIndicator(Map<String, dynamic> prediction) {
    final trendPercentage = 10.0; // Calculate this based on your data
    final isIncrease = trendPercentage > 0;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: (isIncrease ? AppColors.softRed : AppColors.teal)
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
            size: 16,
            color: isIncrease ? AppColors.softRed : AppColors.teal,
          ),
          const SizedBox(width: 4),
          Text(
            '${trendPercentage.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              color: isIncrease ? AppColors.softRed : AppColors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard() {
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
            const Text(
              'Rekomendasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecommendationItem(
              icon: Icons.restaurant,
              title: 'Kurangi Pengeluaran Makanan',
              description:
                  'Pengeluaran kategori makanan 20% lebih tinggi dari biasanya',
              color: AppColors.softRed,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              icon: Icons.directions_car,
              title: 'Transport Masih Optimal',
              description:
                  'Pengeluaran transport masih dalam batas normal',
              color: AppColors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
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
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}