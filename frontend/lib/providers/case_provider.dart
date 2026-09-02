// Location: frontend/lib/providers/case_provider.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CaseProvider extends ChangeNotifier {
  Map<String, dynamic>? _caseData;
  bool _isLoading = false;
  
  // --- THE GHOST ROUTER ---
  bool _useGhostEngine = true; // Set to true by default for your local testing
  bool get isGhostActive => _useGhostEngine;

  // Base URLs
  final String _ghostUrl = 'http://127.0.0.1:8000';
  final String _devanshUrl = 'https://devansh-api-placeholder.com'; // His future URL

  late Dio _dio;

  CaseProvider() {
    _updateDio();
  }

  void _updateDio() {
    _dio = Dio(BaseOptions(baseUrl: _useGhostEngine ? _ghostUrl : _devanshUrl));
  }

  // The Secret Toggle Method
  void silentlyToggleBackend() {
    _useGhostEngine = !_useGhostEngine;
    _updateDio();
    debugPrint("GHOST ROUTER ACTIVE: $_useGhostEngine");
    notifyListeners();
  }
  // ------------------------

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
}