// Location: frontend/lib/core/mock_case_data.dart

const Map<String, dynamic> mockTipResponse = {
  "status": "success",
  "extracted_entities": {
    "time": "18:05",
    "location": "Bus Stand",
    "vehicle": "White Hatchback"
  },
  "relationships": [
    {
      "type": "corroboration",
      "related_statement_id": "STMT-001",
      "summary": "Witness A also reported seeing them at the Bus Stand around 18:00."
    },
    {
      "type": "conflict",
      "related_statement_id": "STMT-003",
      "summary": "Witness C reported them at the Railway Station at 18:00."
    }
  ],
  "ranked_leads": [
    {
      "lead_id": "LEAD-01",
      "location": "Bus Stand Corridor",
      "confidence_score": 0.88,
      "evidence_count": 2,
      "sources": ["STMT-001", "STMT-NEW"]
    },
    {
      "lead_id": "LEAD-02",
      "location": "Railway Station",
      "confidence_score": 0.34,
      "evidence_count": 1,
      "sources": ["STMT-003"]
    }
  ],
  "ai_briefing": "A new tip places the subject at the Bus Stand at 18:05 in a white hatchback, corroborating Witness A. This conflicts with Witness C's timeline at the Railway Station. The Bus Stand corridor is currently the highest-confidence lead."
};