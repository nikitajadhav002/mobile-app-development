import 'package:flutter/material.dart';
import 'book_model.dart';
import 'stats_service.dart';

class StatsProvider with ChangeNotifier {
  final StatsService _statsService = StatsService();
  Map<String, dynamic> _stats = {};

  Map<String, dynamic> get stats => _stats;

  Future<void> fetchStats(List<Book> books) async {
    _stats = await _statsService.getStats(books);
    notifyListeners();
  }
}
