import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../models/category.dart' as models;
import '../services/api_service.dart';

class ExpenseProvider with ChangeNotifier {
  final _apiService = ApiService();
  
  List<Expense> _expenses = [];
  List<models.Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Expense> get expenses => _expenses;
  List<models.Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final expensesData = await _apiService.getExpenses();
      final categoriesData = await _apiService.getCategories();

      _expenses = expensesData.map((e) => Expense.fromJson(e)).toList();
      _categories = categoriesData.map((c) => models.Category.fromJson(c)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  models.Category? getCategoryById(int id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}