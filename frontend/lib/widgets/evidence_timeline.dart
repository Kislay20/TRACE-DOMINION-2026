// Location: frontend/lib/widgets/evidence_timeline.dart
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class EvidenceTimeline extends StatelessWidget {
  final List<dynamic> relationships;

  const EvidenceTimeline({super.key, required this.relationships});

  @override
  Widget build(BuildContext context) {
    if (relationships.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: relationships.length,
      itemBuilder: (context, index) {
        final rel = relationships[index] ?? {};
        
        final typeStr = rel['type']?.toString().toUpperCase() ?? 'SYSTEM UPDATE';
        
        // --- 1. DYNAMIC CYBER COLOR LOGIC ---
        Color nodeColor;
        if (typeStr.contains('CONFLICT')) {
          nodeColor = Colors.redAccent;
        } else if (typeStr.contains('UNCERTAIN')) {
          nodeColor = Colors.amberAccent;
        } else {
          nodeColor = Colors.greenAccent; // Corroboration
        }
        
        final targetIdStr = rel['related_statement_id']?.toString() ?? '';
        final explanationStr = rel['summary']?.toString() ?? 'No summary provided.';
        // ------------------------------------

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.05,
          isFirst: index == 0,
          isLast: index == relationships.length - 1,
          indicatorStyle: IndicatorStyle(
            width: 20,
            color: nodeColor,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // Added a subtle glow to the timeline dot itself
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: nodeColor,
                boxShadow: [
                  BoxShadow(
                    color: nodeColor.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          beforeLineStyle: LineStyle(
            color: nodeColor.withOpacity(0.3),
            thickness: 3,
          ),
          afterLineStyle: LineStyle(
            color: nodeColor.withOpacity(0.3),
            thickness: 3,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            // --- 2. GLASSMORPHISM / HIGH-TECH CARD ---
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // Semi-transparent gradient for depth
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1E2638).withOpacity(0.8),
                    const Color(0xFF2A364F).withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                // Glowing border matching the AI state
                border: Border.all(
                  color: nodeColor.withOpacity(0.5), 
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: nodeColor.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: nodeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          typeStr,
                          style: TextStyle(
                            color: nodeColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        targetIdStr,
                        style: const TextStyle(
                          color: Colors.white54, 
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    explanationStr,
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 14, 
                      height: 1.5,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}