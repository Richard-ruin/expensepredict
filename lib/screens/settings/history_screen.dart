import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:expensepredict/constants/colors.dart';
import 'package:expensepredict/providers/expense_provider.dart';
import 'package:expensepredict/models/expense.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    await provider.loadData();
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
    required DateTime date,
    required String title,
    required double amount,
    required String category,
    required IconData icon,
  }) {
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

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
                  '$category • ${DateFormat('dd MMM yyyy').format(date)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatter.format(amount),
            style: const TextStyle(
              color: AppColors.softRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Expense>> _groupExpensesByMonth(List<Expense> expenses) {
    final grouped = <String, List<Expense>>{};
    for (var expense in expenses) {
      final monthKey = DateFormat('MMMM yyyy').format(expense.date);
      if (!grouped.containsKey(monthKey)) {
        grouped[monthKey] = [];
      }
      grouped[monthKey]!.add(expense);
    }
    return grouped;
  }

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
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final expensesByMonth = _groupExpensesByMonth(provider.expenses);

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: expensesByMonth.length,
            itemBuilder: (context, index) {
              final monthData = expensesByMonth.entries.elementAt(index);
              return _buildMonthSection(
                monthData.key,
                monthData.value.map((expense) {
                  final category = provider.getCategoryById(expense.categoryId);
                  return _buildHistoryItem(
                    date: expense.date,
                    title: expense.description,
                    amount: expense.amount,
                    category: category?.name ?? 'Unknown',
                    icon: Icons.category,
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}