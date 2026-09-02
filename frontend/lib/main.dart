// Location: frontend/lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/case_provider.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CaseProvider()),
      ],
      child: const ThreadlineApp(),
    ),
  );
}

class ThreadlineApp extends StatelessWidget {
  const ThreadlineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THREADLINE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate dark
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}