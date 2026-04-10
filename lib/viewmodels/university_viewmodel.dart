import 'package:flutter/material.dart';
import '../models/university.dart';
import '../services/university_service.dart';

class UniversityViewModel extends ChangeNotifier {
  final UniversityService _service = UniversityService();

  List<University> _universities = [];
  List<University> _visibleUniversities = [];

  bool _isLoading = false;
  bool _isGridView = false;

  int _currentPage = 1;
  final int _pageSize = 20;

  List<University> get visibleUniversities => _visibleUniversities;
  bool get isLoading => _isLoading;
  bool get isGridView => _isGridView;

  Future<void> fetchUniversities() async {
    _isLoading = true;
    notifyListeners();

    try {
      _universities = await _service.fetchUniversities();
      _visibleUniversities = _universities.take(_pageSize).toList();
      _currentPage = 1;
    } catch (e) {
      print('Error fetching universities: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void loadMore() {
    if (_visibleUniversities.length >= _universities.length) return;

    final nextPage = _universities
        .skip(_currentPage * _pageSize)
        .take(_pageSize);

    _visibleUniversities.addAll(nextPage);
    _currentPage++;

    notifyListeners();
  }

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }
}
