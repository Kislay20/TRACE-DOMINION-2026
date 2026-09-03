// Location: frontend/lib/providers/case_provider.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CaseProvider extends ChangeNotifier {
  Map<String, dynamic>? _caseData;
  bool _isLoading = false;
  
  // --- THE OFFICIAL CORE ENGINE ---
  // No more ghost router. This is the only backend that matters now.
  final String _baseUrl = 'http://127.0.0.1:8000';
  late Dio _dio;

  CaseProvider() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }
  // --------------------------------

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
      _caseData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBaseline() async {
    _isLoading = true;
    notifyListeners();
    try {
      // Make sure URL matches your FastAPI server
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/v1/baseline'));
      if (response.statusCode == 200) {
        _caseData = json.decode(response.body);
      }
    } catch (e) {
      debugPrint("Baseline Error: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> resetSystem() async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. Wipe the Python backend memory (Now using Dio for consistency)
      await _dio.post('/api/v1/reset');
      
      // 2. Wipe the Flutter local memory
      _caseData = null; 
    } catch (error) {
      debugPrint("Reset error: $error");
    } finally {
      _isLoading = false;
      notifyListeners(); // Tells the UI to redraw as empty
    }
  }
}