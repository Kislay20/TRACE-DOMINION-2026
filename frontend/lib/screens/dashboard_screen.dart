// Location: frontend/lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/case_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../widgets/evidence_timeline.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  final TextEditingController _tipController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _initSpeech();
    
    // --- FETCH BASELINE ON STARTUP ---
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CaseProvider>().fetchBaseline();
    });
  }

  void _initSpeech() async {
    await _speech.initialize(
      onError: (val) => debugPrint('STT Error: $val'),
      onStatus: (val) => debugPrint('STT Status: $val'),
    );
  }

  @override
  void dispose() {
    _tipController.dispose(); 
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
      if (_tipController.text.isNotEmpty) {
        context.read<CaseProvider>().processNewTip(_tipController.text);
      }
    }
  }

  // --- GOD-LEVEL UI: CYBER-PULSE MIC ---
  Widget _buildPulsingMic() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: _isListening ? 1.3 : 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: _isListening
                  ? [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.3),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ]
                  : [],
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: _isListening ? Colors.redAccent : const Color(0xFF1E293B),
              child: IconButton(
                icon: Icon(
                  _isListening ? Icons.graphic_eq : Icons.mic_none, 
                  color: Colors.white,
                ),
                onPressed: _listen,
              ),
            ),
          ),
        );
      },
    );
  }
  // -------------------------------------
  // --- GOD-LEVEL UI: EXTRACTED ENTITIES HUD ---
  Widget _buildEntityChip(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: Colors.white54),
                const SizedBox(width: 6),
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(fontSize: 10, color: Colors.white54, letterSpacing: 1.2),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // --- GOD-LEVEL UI: PRIORITY LEADS CARD ---
  Widget _buildPriorityLeadCard(Map<String, dynamic> lead, int index) {
    // Convert backend confidence (0.88) to a percentage (88%)
    final confidence = (lead['confidence_score'] as num).toDouble();
    final confPercent = (confidence * 100).toInt();
    
    // Cyber color logic: Green for high confidence, Amber for lower
    final color = confidence >= 0.7 ? Colors.greenAccent : Colors.amberAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          // Give the #1 lead a special glowing cyan border
          color: index == 1 ? Colors.cyanAccent.withOpacity(0.5) : Colors.white12,
          width: index == 1 ? 1.5 : 1.0,
        ),
        boxShadow: index == 1
            ? [BoxShadow(color: Colors.cyanAccent.withOpacity(0.1), blurRadius: 10)]
            : [],
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: index == 1 ? Colors.cyanAccent.withOpacity(0.2) : Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Text(
              '#$index',
              style: TextStyle(
                color: index == 1 ? Colors.cyanAccent : Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Location & Evidence Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead['location']?.toString().toUpperCase() ?? 'UNKNOWN',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Based on ${lead['evidence_count'] ?? 1} correlated statements',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          
          // Confidence Score HUD
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$confPercent%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Text(
                'CONFIDENCE',
                style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // -----------------------------------------
  // --- GOD-LEVEL UI: TACTICAL MAP PLACEHOLDER ---
  Widget _buildTacticalMap(String topLocation) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Deepest background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cyber Radar Rings (Pure Flutter, no images needed)
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.cyanAccent.withOpacity(0.1), width: 1)),
          ),
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 1)),
          ),
          // Pulsing Target Blip
          const Icon(Icons.my_location, color: Colors.cyanAccent, size: 28),
          
          // Tactical HUD Overlay
          Positioned(
            bottom: 12,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('AUTO-LOCATION ACTIVE', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'SECTOR: ${topLocation.toUpperCase()}',
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                ),
                const SizedBox(height: 2),
                // Hardcoded coordinates for the aesthetic
                const Text('LAT: 12.7932 | LNG: 80.0222', style: TextStyle(color: Colors.cyanAccent, fontSize: 10, fontFamily: 'monospace')),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ----------------------------------------------
  @override
  Widget build(BuildContext context) {
    final caseProvider = context.watch<CaseProvider>();
    final caseData = caseProvider.caseData;

    // Unified Theme Colors
    const Color bgColor = Color(0xFF0F172A); 
    const Color surfaceColor = Color(0xFF1E293B); 
    const Color accentColor = Colors.cyanAccent; 

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'THREADLINE | Active Case',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.1),
        ), 
        backgroundColor: surfaceColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: accentColor),
            tooltip: 'Reset Case Memory',
            onPressed: () async {
              await context.read<CaseProvider>().resetSystem();
              if (context.mounted) context.read<CaseProvider>().fetchBaseline();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('System Reset. Ready for new case.', style: TextStyle(color: Colors.white)),
                    backgroundColor: surfaceColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
      // --- FIX: ADDED SingleChildScrollView HERE ---
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- CONTROL PANEL ---
              Row(
                children: [
                  _buildPulsingMic(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _tipController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter new tip (e.g., "Saw them at the railway station...")',
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: surfaceColor,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: accentColor, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 52, // Match TextField height
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send, size: 18),
                      label: const Text('PROCESS', style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: surfaceColor,
                        foregroundColor: accentColor,
                        side: const BorderSide(color: accentColor, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: caseProvider.isLoading 
                          ? null 
                          : () {
                              if (_tipController.text.isNotEmpty) {
                                context.read<CaseProvider>().processNewTip(_tipController.text);
                                _tipController.clear();
                              }
                            },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Loading State
              if (caseProvider.isLoading)
                const Center(child: CircularProgressIndicator(color: accentColor)),

              // Data State
              if (caseData != null && !caseProvider.isLoading) ...[
                // --- EXTRACTED ENTITIES HUD ---
                const Text(
                  'EXTRACTED ENTITIES',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildEntityChip(Icons.access_time, 'Time', caseData['extracted_entities']['time'] ?? 'Unknown'),
                    const SizedBox(width: 12),
                    _buildEntityChip(Icons.location_on, 'Location', caseData['extracted_entities']['location'] ?? 'Unknown'),
                    const SizedBox(width: 12),
                    _buildEntityChip(Icons.directions_car, 'Vehicle', caseData['extracted_entities']['vehicle'] ?? 'None'),
                  ],
                ),
                const Divider(height: 32, color: Colors.white12),
                // ----------------------------------

                // --- ADD THE TACTICAL MAP HERE ---
                _buildTacticalMap(caseData['ranked_leads'][0]['location']?.toString() ?? 'UNKNOWN'),
                // ---------------------------------

                const Text(
                  'PRIORITY LEADS',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Dynamically build the list of leads
                ...List.generate(
                  (caseData['ranked_leads'] as List).length,
                  (index) => _buildPriorityLeadCard(caseData['ranked_leads'][index], index + 1),
                ),

                const Divider(height: 32, color: Colors.white12),

                const Text(
                  'STATEMENT CROSS-REFERENCE:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 12),
                EvidenceTimeline(relationships: caseData['relationships']),
                const Divider(height: 32, color: Colors.white12),

                const Text(
                  'AI Briefing:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  caseData['ai_briefing'],
                  style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.4),
                ),
              ],

              // Empty State
              // --- FIX: Removed Expanded, added padding instead to push it down visually ---
              if (caseData == null && !caseProvider.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: Text(
                      'Awaiting field inputs...',
                      style: TextStyle(color: Colors.white38, fontSize: 16, letterSpacing: 1.1),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}