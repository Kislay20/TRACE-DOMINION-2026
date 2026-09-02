# THREADLINE — 7-Slide Presentation Deck Outline
**Event:** DOMINION 2026 Hackathon  
**Project:** THREADLINE (Agentic Evidence Reconciliation Engine)  
**Target Format:** 16:9 High-Contrast Tactical Widescreen Pitch Deck  
**Presenter Team:** Trace Dominion (Members 1–4)  

---

## Slide 1: Title & Positioning

* **Category:** Title / Vision Anchor
* **Slide Title:** `THREADLINE // COMMAND OS`
* **Subtitle:** *Real-Time Evidence Reconciliation for Search & Rescue Operations*

### Core Visual / Layout Concept
* Dark obsidian backdrop (`#070A11`) with glowing cybernetic grid and an elevated tactical status badge: `[● LIVE RECONCILIATION ENGINE ACTIVE]`.
* Centered product title in bold monospace typography with subtle cyan/emerald ambient gradient.
* Bottom split bar displaying:
  * Left: `Case ID: #CASE-2026-089A`
  * Center: `Target: Tactical Incident Coordinators`
  * Right: `DOMINION 2026`

### Key Bullet Points (Exact Slide Text)
* **Real-Time Intelligence Synthesis:** Turns chaotic public tips into an actionable graph of truth.
* **Purpose-Built Decision Support:** Designed specifically for search coordinators during high-stakes search operations.
* **Human-in-the-Loop Mission Control:** Zero automated actions—empowers coordinators to verify and dispatch faster.

### Speaker Notes (Word-for-Word Talking Points)
> *"Good morning, judges. In critical search and rescue operations, the limiting factor is rarely a lack of information—it is the overwhelming cognitive burden of manual synthesis. We are Team Trace Dominion, and this is THREADLINE: an agentic evidence reconciliation engine built to empower search coordinators with real-time, verified intelligence."*

---

## Slide 2: The Golden Hour Problem

* **Category:** Problem Statement & Operational Context
* **Slide Title:** `The Golden Hour Crisis: The Failure of Manual Synthesis`

### Core Visual / Layout Concept
* A 3-box visual contrast illustrating operational friction:
  1. **Tip Flood (Left Box):** Chaotic waterfall of raw inputs (Audio hotline, SMS tips, web portal forms).
  2. **The Bottleneck (Center Box - Crimson Accent `#EF4444`):** Stressed coordinator with whiteboard arrows, sticky notes, and conflicting 18:00 timestamps.
  3. **The Result (Right Box):** Split search units, lost transit windows, delayed field dispatch.
* Big Metric Callout in center: `60 MIN` (*The Golden Hour Survival Window*).

### Key Bullet Points (Exact Slide Text)
* **The Golden Hour Dilemma:** First 60 minutes determine survival; tip volume spikes exponentially.
* **Contradictory Signal Overload:** 40%+ of initial witness statements contain spatio-temporal contradictions.
* **Whiteboard Bottlenecks:** Manual sticky-note or spreadsheet tallying causes decision paralysis and split search perimeters.
* **Chatbots Fail Here:** Naive LLMs lack persistent graph state, hallucinate timelines, and cannot mathematically rank competing leads.

### Speaker Notes (Word-for-Word Talking Points)
> *"When a person goes missing, the first hour is critical. But coordinators don't suffer from empty inboxes—they drown in a flood of unverified, conflicting reports. Witness A says the Bus Stand at 6:00 PM; Witness C says the Railway Station at 6:00 PM. Humans cannot cross-reference dozens of multi-variable witness statements in their heads under intense stress, and standard LLM chatbots hallucinate without structured state. This manual bottleneck costs lives."*

---

## Slide 3: The Solution (Agentic Reconciliation)

* **Category:** Product Solution & Core Philosophy
* **Slide Title:** `The Solution: Deterministic Agentic Evidence Reconciliation`

### Core Visual / Layout Concept
* Horizontal 7-Stage Agentic Pipeline Diagram with animated glowing data pulses moving from left to right:
  `[ 🎙 INGEST ] ➔ [ 📝 TRANSCRIBE ] ➔ [ 🔍 EXTRACT ] ➔ [ 🗄 RETRIEVE ] ➔ [ ⚖️ COMPARE ] ➔ [ 📊 RANK ] ➔ [ 📄 BRIEF ]`
* Callout Pill: `NOT A CHATBOT // AN ACTIVE REASONING GRAPH`

### Key Bullet Points (Exact Slide Text)
* **Agentic, Not Conversational:** Autonomous background pipeline executing without conversational prompting.
* **Structured Spatio-Temporal Extraction:** Converts messy text and voice into normalized entities: `(Time, Location, Vehicle, Physical Markers)`.
* **Graph Comparison Engine:** Continuously evaluates spatial distance ($\Delta d$) and temporal window ($\Delta t$) against all active statements.
* **Dynamic Situation Briefing:** Gemini pipeline generates 3-sentence dynamic operational shifts with clickable source citations.

### Speaker Notes (Word-for-Word Talking Points)
> *"THREADLINE is fundamentally different from a chatbot. It is a proactive agentic pipeline. The moment audio or text enters the system, it is automatically transcribed, parsed for key entities, cross-referenced against historical statements, mathematically evaluated for corroborations or conflicts, and synthesized into a prioritized lead hierarchy—all in under two seconds."*

---

## Slide 4: System Architecture & Intelligence Engine

* **Category:** Technical Architecture & Tech Stack
* **Slide Title:** `System Architecture: From Acoustic Waveform to Command UI`

### Core Visual / Layout Concept
* 3-Tier Layered Architecture Diagram:
  * **Ingestion Layer (Top):** Voice dictation, Webhooks, REST API (`FastAPI`).
  * **Intelligence Core (Middle):** Google Gemini 1.5 Flash (Structured Outputs) + Vector Embeddings + Spatio-Temporal Conflict Matrix.
  * **Tactical Command UI (Bottom):** Flutter Web & Desktop (60fps reactive dual-column dashboard, 65/35 split).

```text
+-----------------------------------------------------------------------------+
| INGESTION LAYER      FastAPI Webhooks · Audio Dictation · Field REST API    |
+-----------------------------------------------------------------------------+
                                       |
+-----------------------------------------------------------------------------+
| RECONCILIATION CORE  Gemini 1.5 Flash · Entity Extraction · Conflict Matrix  |
|                      Spatiotemporal Geo-Delta Calculations                  |
+-----------------------------------------------------------------------------+
                                       |
+-----------------------------------------------------------------------------+
| TACTICAL FRONTEND    Flutter 3.x Desktop/Web · 65/35 Dual Column · Reactive |
+-----------------------------------------------------------------------------+
```

### Key Bullet Points (Exact Slide Text)
* **High-Throughput Backend:** FastAPI asynchronous pipeline handling concurrent multi-channel tip streams.
* **Gemini 1.5 Flash Core:** High-speed, low-latency entity normalization with strict JSON schema constraints.
* **Deterministic Reconciliation Logic:** Mathematical delta engine evaluates geographical feasibilities ($>2\text{km}$ in $5\text{min} \rightarrow \text{Conflict}$).
* **Tactical Command Frontend:** Flutter multiplatform interface designed for zero-latency screen re-ranking.

### Speaker Notes (Word-for-Word Talking Points)
> *"Our tech stack is built for high speed and absolute determinism. The backend runs on FastAPI, ingesting raw audio and text. Gemini 1.5 Flash extracts structured JSON entities within milliseconds. Our custom spatial reconciliation engine calculates physical travel feasibility, flagging conflicts and elevating corroborated clusters, which stream instantly to a tactical Flutter dashboard."*

---

## Slide 5: The Live Demo Anchor

* **Category:** Live Demonstration & Core Value Proposition
* **Slide Title:** `"One New Tip. The Whole Case Updates."`

### Core Visual / Layout Concept
* Split "Before vs. After" Dashboard Transformation Graphic:
  * **Left (Before Ingestion):** Split baseline ambiguity (`Bus Stand 52%` vs `Railway Station 48%`).
  * **Middle:** Spoken Tip (`"Saw person near bus stand at 6:05 PM in white hatchback"`).
  * **Right (After Reconciling):** 
    * `#1 Bus Stand Corridor (88% Confidence)` with Emerald `[✓ Corroborated]` badge.
    * `#2 Railway Station (34%)` with Crimson `[⚠ Conflict]` badge.

### Key Bullet Points (Exact Slide Text)
* **Baseline Ambiguity:** Conflicting witness reports paralyze search coordinator dispatch.
* **Instant Entity Extraction:** Ingests tip $\rightarrow$ extracts `18:05`, `Bus Stand`, `White Hatchback`.
* **Simultaneous Corroboration & Conflict:**
  * Corroborates Witness A at Bus Stand North.
  * Automatically isolates Witness C's contradictory Railway Station report.
* **Autonomous Lead Elevation:** Bus Stand surges to `#1 Lead` ($88\%$), ready for immediate team dispatch.

### Speaker Notes (Word-for-Word Talking Points)
> *"Here is the core breakthrough in action: One new tip arrives, and the entire case updates. Watch our live demo: A single voice tip stating a white hatchback was spotted at the Bus Stand at 6:05 PM instantly corroborates Witness A, exposes the Railway Station report as a physical impossibility, and surges the Bus Stand corridor to our number one priority lead at 88% confidence."*

---

## Slide 6: Safety, Ethics & Human-in-the-Loop

* **Category:** Governance, Ethics & Trust
* **Slide Title:** `Safety & Ethics: AI Assists, Humans Decide`

### Core Visual / Layout Concept
* 4 Shield Icons highlighting tactical safety guardrails:
  1. 🛡️ **Source-Traceable Citations** (Hover pill mockup showing `[STMT-001]` grounding).
  2. 🛡️ **Zero Mass Surveillance** (Icon showing no facial recognition, no automated phone tracking).
  3. 🛡️ **Synthetic Data Compliance** (GDPR/CJIS aligned test architectures).
  4. 🛡️ **Mandatory Human Dispatch Gate** (Clickable `[ Verify & Dispatch -> ]` button mockup).

### Key Bullet Points (Exact Slide Text)
* **No Black Boxes:** Every summary statement and lead ranking is explicitly linked to raw witness citations.
* **Zero Autonomous Action:** System generates intelligence recommendations; human coordinators retain sole dispatch authority.
* **Privacy-First Architecture:** No facial recognition, persistent biometrics, or passive bulk data scraping.
* **Auditable Chain of Custody:** Immutable logging of all statement ingestions, entity extractions, and operator overrides.

### Speaker Notes (Word-for-Word Talking Points)
> *"In public safety, unconstrained AI is dangerous. THREADLINE operates under strict ethical guardrails: AI assists, but humans decide. There is no mass surveillance, no facial recognition, and no autonomous police action. Every lead provides direct clickable citations back to the raw witness statements, ensuring 100% explainability and operational accountability."*

---

## Slide 7: Phase 2 Future Roadmap

* **Category:** Scalability & Future Vision
* **Slide Title:** `Roadmap: The Future of Incident Intelligence`

### Core Visual / Layout Concept
* 4-Quarter Horizon Timeline Roadmap:
  * **Q2 2026 (Tactical GIS):** Dynamic geo-spatial isochrone heatmaps & search perimeter overlays.
  * **Q3 2026 (Multi-Agency Federation):** Inter-departmental syncing (Police, Fire, SAR, K9 units).
  * **Q4 2026 (Multilingual Voice Intake):** Real-time multilingual ingestion across 20+ dialects.
  * **2027 (Cross-Incident Analytics):** Pattern matching across serial incidents and historical terrain records.

### Key Bullet Points (Exact Slide Text)
* **Tactical GIS Heatmaps:** Isochrone escape radius modeling based on terrain and extracted vehicle speeds.
* **Multi-Agency Command Federation:** Real-time synchronized dispatch between Police, Fire, Mountain SAR, and K9 units.
* **Multilingual Audio Ingestion:** Automatic transcription and translation for non-English emergency hotline callers.
* **Offline Edge Deployment:** Lightweight on-device models for rural search operations without cellular connectivity.

### Speaker Notes (Word-for-Word Talking Points)
> *"Looking ahead, our Phase 2 roadmap expands THREADLINE into a comprehensive tactical ecosystem. We are integrating isochrone GIS heatmaps to calculate physical search radii, multi-agency federation to link Police, SAR, and K9 units in real time, and offline edge deployments for wilderness rescues without cell signal. Thank you, and we look forward to your questions."*

---

*Presentation deck outline completed for DOMINION 2026 Hackathon.*
