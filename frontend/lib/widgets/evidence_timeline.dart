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
      physics: const NeverScrollableScrollPhysics(), // Let the main screen handle scrolling
      itemCount: relationships.length,
      itemBuilder: (context, index) {
        // --- THE PRECISION JSON PARSER ---
        final rel = relationships[index] ?? {};
        
        final typeStr = rel['type']?.toString().toUpperCase() ?? 'SYSTEM UPDATE';
        final isConflict = typeStr.contains('CONFLICT');
        final nodeColor = isConflict ? Colors.redAccent : Colors.greenAccent;
        
        // Using Jatin's exact ID key
        final targetIdStr = rel['related_statement_id']?.toString() ?? '';
            
        // Using Jatin's exact text key
        final explanationStr = rel['summary']?.toString() ?? 'No summary provided.';
        // ---------------------------------

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.05, // Pushes the line to the left edge
          isFirst: index == 0,
          isLast: index == relationships.length - 1,
          indicatorStyle: IndicatorStyle(
            width: 20,
            color: nodeColor,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          beforeLineStyle: LineStyle(
            color: nodeColor.withOpacity(0.4),
            thickness: 3,
          ),
          afterLineStyle: LineStyle(
            color: nodeColor.withOpacity(0.4),
            thickness: 3,
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A364F), // Dark UI card match
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: nodeColor.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        typeStr,
                        style: TextStyle(
                          color: nodeColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        targetIdStr,
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    explanationStr,
                    style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
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