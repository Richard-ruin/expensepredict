// lib/screens/expenses/widgets/expense_form.dart
import 'package:flutter/material.dart';
import 'package:expensepredict/widgets/common/custom_card.dart';
import 'package:expensepredict/widgets/common/custom_button.dart';
import 'package:expensepredict/constants/colors.dart';

class ExpenseForm extends StatelessWidget {
  final Function(Map<String, dynamic>)? onSubmit;

  const ExpenseForm({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detail Pengeluaran',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Jumlah',
              prefixIcon: const Icon(Icons.attach_money),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Kategori',
              prefixIcon: const Icon(Icons.category),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'makanan', child: Text('Makanan')),
              DropdownMenuItem(value: 'transport', child: Text('Transport')),
              DropdownMenuItem(value: 'belanja', child: Text('Belanja')),
              DropdownMenuItem(value: 'lainnya', child: Text('Lainnya')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Catatan',
              prefixIcon: const Icon(Icons.note),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'Simpan',
              icon: Icons.save,
              onPressed: () {
                if (onSubmit != null) {
                  onSubmit!({
                    'amount': 0,
                    'category': 'makanan',
                    'note': '',
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}