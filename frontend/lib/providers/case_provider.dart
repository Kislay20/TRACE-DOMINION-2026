// Location: frontend/lib/providers/case_provider.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CaseProvider extends ChangeNotifier {
  Map<String, dynamic>? _caseData;
  bool _isLoading = false;
  
  // Use 10.0.2.2 if testing on Android emulator, otherwise localhost for Web/Desktop
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000'));

  Map<String, dynamic>? get caseData => _caseData;
  bool get isLoading => _isLoading;

  Future<void> processNewTip(String textTip) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.post('/api/v1/tips', data: {
        "case_id": "CASE-101",
        "source_type": "text",
        "raw_text": textTip,
        "timestamp": DateTime.now().toUtc().toIso8601String(),
      });

      if (response.statusCode == 200) {
        _caseData = response.data;
      }
    } catch (e) {
      debugPrint("API Error: $e");
      // Fallback for demo purposes if backend fails
      _caseData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}