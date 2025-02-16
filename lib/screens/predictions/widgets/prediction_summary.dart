// lib/screens/predictions/widgets/prediction_summary.dart
import 'package:flutter/material.dart';
import 'package:expensepredict/services/api_service.dart';
import 'package:expensepredict/models/category.dart';
import 'package:intl/intl.dart';



class PredictionSummary extends StatefulWidget {
  const PredictionSummary({super.key});

  @override
  State<PredictionSummary> createState() => _PredictionSummaryState();
}

class _PredictionSummaryState extends State<PredictionSummary> {
  final _apiService = ApiService();
  Map<String, dynamic> _insights = {};
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final insights = await _apiService.getInsights();
      final categoriesData = await _apiService.getCategories();

      setState(() {
        _insights = insights;
        _categories = categoriesData.map((c) => Category.fromJson(c)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Handle error
    }
  }

  String _formatAmount(double amount) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  Category? _getCategoryById(int id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Get highest spending category
    int? highestSpendingCategoryId;
    double highestAmount = 0;

    _insights.forEach((categoryId, data) {
      if (data['total'] > highestAmount) {
        highestAmount = data['total'];
        highestSpendingCategoryId = int.parse(categoryId);
      }
    });

    final highestSpendingCategory = highestSpendingCategoryId != null 
    ? _getCategoryById(highestSpendingCategoryId!)  // Tambahkan ! untuk null assertion
    : null;

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pengeluaran Tertinggi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (highestSpendingCategory != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.category,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              highestSpendingCategory.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatAmount(highestAmount),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Trend Pengeluaran per Kategori',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final categoryData = _insights[category.id.toString()];
                    
                    if (categoryData == null) return const SizedBox.shrink();

                    final trendPercentage = categoryData['trend_percentage'] ?? 0.0;
                    final isIncrease = trendPercentage > 0;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(category.name),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              _formatAmount(categoryData['recent_total'] ?? 0.0),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isIncrease 
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isIncrease 
                                      ? Icons.arrow_upward 
                                      : Icons.arrow_downward,
                                  size: 16,
                                  color: isIncrease ? Colors.red : Colors.green,
                                ),
                                Text(
                                  '${trendPercentage.toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    color: isIncrease ? Colors.red : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}