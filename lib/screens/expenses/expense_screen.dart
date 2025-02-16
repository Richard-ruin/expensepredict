// lib/screens/expenses/expense_screen.dart
import 'package:expensepredict/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:expensepredict/screens/expenses/widgets/expense_form.dart';
import 'package:expensepredict/screens/expenses/widgets/expense_list.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Pengeluaran',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(height: 24),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: ExpenseForm(),
                ),
              ),
              const SizedBox(height: 24),
              const ExpenseList(),
            ],
          ),
        ),
      ),
    );
  }
}