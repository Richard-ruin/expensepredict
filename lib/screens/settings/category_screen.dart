// lib/screens/settings/category_screen.dart
import 'package:flutter/material.dart';
import 'package:expensepredict/constants/colors.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Makanan', 'icon': Icons.restaurant, 'color': AppColors.teal},
    {'name': 'Transport', 'icon': Icons.directions_car, 'color': AppColors.warmOrange},
    {'name': 'Belanja', 'icon': Icons.shopping_cart, 'color': AppColors.softRed},
    {'name': 'Utilitas', 'icon': Icons.power, 'color': AppColors.goldenYellow},
    {'name': 'Hiburan', 'icon': Icons.movie, 'color': AppColors.darkBlue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Pengeluaran'),
        backgroundColor: AppColors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['color'] as Color,
                    ),
                  ),
                  title: Text(category['name'] as String),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.teal),
                        onPressed: () => _showCategoryDialog(context, category),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.softRed),
                        onPressed: () => _showDeleteDialog(context, category),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.teal,
        onPressed: () => _showCategoryDialog(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showCategoryDialog(
      BuildContext context, Map<String, dynamic>? category) {
    final isEditing = category != null;
    final nameController =
        TextEditingController(text: isEditing ? category['name'] as String : '');

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Kategori' : 'Tambah Kategori'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Kategori',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Add icon picker and color picker if needed
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.teal,
            ),
            onPressed: () {
              // Handle save category
              Navigator.pop(context);
            },
            child: Text(isEditing ? 'Simpan' : 'Tambah'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(
      BuildContext context, Map<String, dynamic> category) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Kategori'),
        content:
            Text('Apakah Anda yakin ingin menghapus kategori ${category['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.softRed,
            ),
            onPressed: () {
              // Handle delete category
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
