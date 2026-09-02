// Location: frontend/lib/widgets/relationship_card.dart
import 'package:flutter/material.dart';

class RelationshipList extends StatelessWidget {
  final List<dynamic> relationships;

  const RelationshipList({super.key, required this.relationships});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: relationships.map((rel) {
        final isConflict = rel['type'] == 'conflict';
        
        return Card(
          color: isConflict ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isConflict ? Colors.redAccent : Colors.greenAccent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              isConflict ? Icons.warning_amber_rounded : Icons.check_circle_outline,
              color: isConflict ? Colors.redAccent : Colors.greenAccent,
            ),
            title: Text(
              isConflict ? 'CONFLICT DETECTED' : 'CORROBORATION',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isConflict ? Colors.redAccent : Colors.greenAccent,
                fontSize: 12,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(rel['summary'], style: const TextStyle(color: Colors.white70)),
            ),
            trailing: Text(
              rel['related_statement_id'], 
              style: const TextStyle(color: Colors.white38, fontSize: 10),
            ),
          ),
        );
      }).toList(),
    );
  }
}