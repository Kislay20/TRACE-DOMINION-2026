// Location: frontend/lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/case_provider.dart';
import '../widgets/relationship_card.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// Changed to StatefulWidget
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Controller now safely lives in the State class
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  final TextEditingController _tipController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speech.initialize(
      onError: (val) => debugPrint('STT Error: $val'),
      onStatus: (val) => debugPrint('STT Status: $val'),
    );
  }

  @override
  void dispose() {
    _tipController.dispose(); // Always dispose controllers to prevent memory leaks
    super.dispose();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _tipController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      // Optional: Auto-process when they stop speaking
      if (_tipController.text.isNotEmpty) {
        context.read<CaseProvider>().processNewTip(_tipController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final caseProvider = context.watch<CaseProvider>();
    final caseData = caseProvider.caseData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('THREADLINE | Active Case'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CONTROL PANEL ---
            Row(
              children: [
                IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    color: _isListening ? Colors.redAccent : Colors.white,
                    onPressed: _listen,
                  ),
                Expanded(
                  child: TextField(
                    controller: _tipController,
                    decoration: const InputDecoration(
                      hintText: 'Enter new tip (e.g., "Saw them at the railway station...")',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text('Process Tip'),
                  onPressed: caseProvider.isLoading 
                      ? null 
                      : () {
                          if (_tipController.text.isNotEmpty) {
                            context.read<CaseProvider>().processNewTip(_tipController.text);
                            _tipController.clear();
                          }
                        },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Loading State
            if (caseProvider.isLoading)
              const Center(child: CircularProgressIndicator()),

            // Data State
            if (caseData != null && !caseProvider.isLoading) ...[
              const Text(
                'LIVE EVIDENCE RECONCILIATION',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Top Lead: ${caseData['ranked_leads'][0]['location']}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Confidence: ${caseData['ranked_leads'][0]['confidence_score']}',
                style: const TextStyle(color: Colors.greenAccent),
              ),
              const Divider(height: 32),

              const Text(
                'STATEMENT CROSS-REFERENCE:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              RelationshipList(relationships: caseData['relationships']),
              const Divider(height: 32),

              const Text(
                'AI Briefing:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                caseData['ai_briefing'],
                style: const TextStyle(fontSize: 16),
              ),
            ],

            // Empty State
            if (caseData == null && !caseProvider.isLoading)
              const Expanded(
                child: Center(child: Text('Waiting for field inputs...')),
              ),
          ],
        ),
      ),
    );
  }
}