# THREADLINE — Phase 2 Product Vision & Tactical UI Specification
**Project:** DOMINION 2026 Hackathon  
**Document:** Phase 2 Future Roadmap & UI Layout Requirements  
**Target Deck Slide:** Slide 7 (Phase 2 Future Roadmap)  
**Target Design Tool:** Figma & Flutter Desktop/Widescreen Implementation  

---

## 1. Executive Vision: The Multi-Jurisdictional Tactical Network

In Phase 1 (DOMINION 2026 MVP), THREADLINE established the foundational breakthrough: **real-time agentic evidence reconciliation for single-case incident triage**. In under two seconds, incoming tips are parsed, spatio-temporal contradictions are flagged, and prioritized leads are mathematically scored with source traceability.

In **Phase 2**, THREADLINE scales from an isolated incident dashboard into a **federated, multi-jurisdictional tactical intelligence network**. Search operations across municipal boundaries, state borders, and diverse agency siloes (Police, Fire, Mountain SAR, Transit Authorities, Citizen Volunteer Groups) will share a unified, live graph of truth without compromising security, chain of custody, or human command authority.

```text
+---------------------------------------------------------------------------------------------------+
|                                 PHASE 2 STRATEGIC HORIZON                                         |
+------------------------------------+--------------------------------------------------------------+
| Phase 1 MVP (Current Baseline)     | Phase 2 Enterprise Tactical Network                          |
+------------------------------------+--------------------------------------------------------------+
| • Single-incident scope (#089A)    | • Federated multi-agency synchronization (CAD / SAR / Transit)|
| • Tabular chronological timeline   | • Real-time terrain-aware GIS Isochrone heatmaps             |
| • English audio & text ingestion   | • Multilingual real-time dialect intake (20+ Indian languages)|
| • Isolated case memory             | • Cross-case serial entity linking & pattern matching        |
| • Cloud-tethered FastAPI backend   | • Edge-deployable offline tactical units for wilderness SAR  |
+------------------------------------+--------------------------------------------------------------+
```

---

## 2. Four Core Phase 2 Capabilities

### 2.1 GIS Tactical Isochrone & Movement Probability Heatmap
* **Capability Overview:** Translates temporal extractions and vehicle classifications into dynamic spatial probability envelopes.
* **Algorithmic Modeling:**
  * **Pedestrian Model ($4.5\,\text{km/h}$ baseline):** Calculates walkable radial buffers factoring in slope, water bodies, and urban fence barriers.
  * **Vehicle Model (Extracted Speed Vectors):** When a tip indicates a vehicle (e.g., *"White Hatchback heading East at 18:05"*), the engine calculates road-network reachable isochrones adjusting for traffic congestion and highway speed limits ($60\text{--}90\,\text{km/h}$).
  * **Probability Decay Heatmap:** Renders dynamic Gaussian gradient overlays on top of satellite/street vector tiles, visually contracting search sectors as time advances.
* **UI Integration:** Toggleable split-view (`[ 🗺 MAP VIEW ]` / `[ 📋 LEADS VIEW ]`) or picture-in-picture tactical overlay.

---

### 2.2 Multi-Agency Federation Bar
* **Capability Overview:** Bridges the communication gap between dispatch centers, patrol cruisers, transit police, and volunteer ground teams.
* **Federation Nodes:**
  1. **Municipal Police CAD (Computer-Aided Dispatch):** Bi-directional REST/WebSocket link to auto-populate unit call signs (e.g., `UNIT-402`, `K9-01`).
  2. **Transit & Highway Authority:** Live feeds from toll plaza ANPR/CCTV extractions and bus terminal telemetry.
  3. **Mountain / Wilderness Search & Rescue (SAR):** Low-bandwidth mesh-network synchronization for search dog handlers and drone operators.
* **Security & Access Control:** Role-Based Access Control (RBAC) ensuring external agencies see verified leads while protecting sensitive witness identities.

---

### 2.3 Cross-Case Serial Entity Linking
* **Capability Overview:** Autonomous background graph traversal detecting recurring actors, license plates, physical descriptions, and MOs across separate concurrent or historical cases.
* **Operational Value:**
  * If a *"White Hatchback with partial plate 482"* is logged in `#CASE-2026-089A` and appears in `#CASE-2026-074B` (armed robbery 12 km away), THREADLINE flags a `[ 🔗 SERIAL CORRELATION ]` alert.
  * Preserves separate case jurisdictions while surfacing critical cross-boundary linkages.

---

### 2.4 Multilingual Real-Time Audio Transcription (Indian Regional Dialects)
* **Capability Overview:** Native support for multi-dialect speech recognition and code-switching across the Indian subcontinent.
* **Supported Dialects & Languages:** Hindi, Marathi, Tamil, Telugu, Kannada, Bengali, Gujarati, Punjabi, and English-Hindi mixed code (*Hinglish*).
* **Zero-Loss Entity Normalization:** Local slang and regional colloquialisms (e.g., *"Gaddi"*, *"Naka"*, *"Chowk"*, *"Adda"*) are canonically normalized to standard graph entities (`Vehicle`, `Checkpoint`, `Intersection`, `Terminal`).

---

## 3. Phase 2 Tactical Command Console — ASCII Wireframe

```text
+-------------------------------------------------------------------------------------------------------------------------------------------------------+
|  THREADLINE // COMMAND OS v2.0-FEDERATED                       CASE: #CASE-2026-089A | SUBJ: Male, 178cm, Dark Jacket      [T+ 03:42:15] [OPERATOR: KISLAY] |
|  [● LIVE RECONCILIATION ACTIVE]  |  FEDERATION: [✓ POLICE CAD] [✓ TRANSIT AUTH] [✓ K9 VOLUNTEER] [⚠ METRO TOLL SYNC]   |  LANG: [ AUTO-DETECT: HINDI/ENG ]   |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+
|                                                                                           |                                                           |
|  PRIMARY COMMAND WORKSPACE (60% Width)                                                    |  SECONDARY WORKSPACE (40% Width)                          |
|                                                                                           |                                                           |
|  +-- [TACTICAL ISOCHRONE MAP & GIS HEATMAP VIEWPORT] ----------------------------------+  |  +-- [EVIDENCE STREAM & MULTILINGUAL INGESTION] --------+ |
|  |  [ MODE: SATELLITE + ROAD ISOCRONE ] [ VEHICLE: WHITE HATCHBACK (60 KM/H BUFFER) ] |  |  |  14 INGESTED TIPS  |  [ 🌐 MULTI-DIALECT ACTIVE ]   | |
|  |  +-------------------------------------------------------------------------------+  |  +------------------------------------------------------+ |
|  |  |                 [ 15-MIN ISOCHRONE BOUNDARY (HWY 9 EAST) ]                    |  |  | [TIP-05 · AUDIO (HINDI)] 18:08:12                   | |
|  |  |                                  (HIGHWAY TOLL)                               |  |  |  "गाड़ी बस स्टैंड से हाईवे की तरफ गई है..."       | |
|  |  |                                         \                                     |  |  |  [TRANSLATION: "Car left bus stand towards hwy"]| |
|  |  |        [ 📍 BUS STAND (PROB: 88%) ] ======> [ 📍 PROBABLE SECTOR 4 ]          |  |  |  +----------------+  +-------------------------+  | |
|  |  |                     \                                                         |  |  |  | 🕒 18:07        |  | 📍 Hwy 9 Sector 4       |  | |
|  |  |          [ ⚠ RAILWAY STN (34% - CONFLICT) ]                                   |  |  |  +----------------+  +-------------------------+  | |
|  |  |                                                                               |  |  |  [✓ Corroborated] Matches Bus Stand Vehicle Vector| |
|  |  +-------------------------------------------------------------------------------+  |  +------------------------------------------------------+ |
|  +-------------------------------------------------------------------------------------+  |                                                           |
|                                                                                           |  +-- [CROSS-CASE SERIAL LINKING ALERT] ----------------+ |
|  +-- [RANKED PRIORITY LEADS & UNIT DISPATCH] ------------------------------------------+  |  |  🔗 CORRELATION DETECTED: #CASE-2026-074B           | |
|  |  #1  BUS STAND -> HWY 9 CORRIDOR                     [ 92% PROBABILITY  ● ]          |  |  Vehicle Match: "White Hatchback (DL-04-XX)"         | |
|  |      Units Assigned: [ PATROL-12 ] [ K9-02 ]          [ DISPATCHED: 18:06 ]         |  |  Reported 24 hrs ago in neighboring sector.         | |
|  |                                                                                     |  +------------------------------------------------------+ |
|  |  #2  RAILWAY STATION PLATFORM 2                      [ 28% PROBABILITY  ⚠ ]          |                                                           |
|  |      Status: Overruled by Highway Sighting            [ STANDBY REVIEW ]            |  +-- [INGESTION & FEDERATED DISPATCH BAR] -------------+ |
|  +-------------------------------------------------------------------------------------+  |  |  [ + TEXT TIP ]  [ 🎙 MULTI-VOICE ]  [ 📡 CAD BROADCAST]| |
|                                                                                           |  +------------------------------------------------------+ |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+
```

---

## 4. Figma Design Guidelines & Tokens

### 4.1 Frame Setup & Canvas Properties
* **Target Frame:** Desktop Widescreen / 1080p
* **Width:** `1920px`
* **Height:** `1080px`
* **Layout Grid (12-Column Responsive Grid):**
  * **Count:** 12 Columns
  * **Margin:** `24px` (Left & Right)
  * **Gutter:** `16px`
  * **Column Width:** `~141.3px`
  * **Flex Division:**
    * Left Primary Workspace: Columns 1 through 7 (Columns 1–7 = `1084px`, ~58%)
    * Right Intelligence Workspace: Columns 8 through 12 (Columns 8–12 = `764px`, ~42%)

---

### 4.2 Extended Visual Tokens (Phase 2 Palette)

```dart
// Location: frontend/lib/core/phase2_theme_tokens.dart

import 'package:flutter/material.dart';

class Phase2Colors {
  // Base Obsidian Canvas
  static const Color canvasBackground   = Color(0xFF070A11);
  static const Color surfaceCard        = Color(0xFF0F172A);
  static const Color surfaceElevated    = Color(0xFF1E293B);
  static const Color borderDefault      = Color(0xFF334155);

  // Status & Reconciliation
  static const Color corroborationGreen = Color(0xFF10B981);
  static const Color conflictRed        = Color(0xFFEF4444);
  static const Color uncertaintyAmber   = Color(0xFFF59E0B);
  static const Color commandCyan        = Color(0xFF38BDF8);

  // Phase 2 New Capability Accents
  static const Color isochroneGlow      = Color(0xFF06B6D4); // Cyan-500: Radial Buffer
  static const Color federationBlue     = Color(0xFF3B82F6); // Blue-500: Multi-agency Sync
  static const Color crossCasePurple    = Color(0xFF8B5CF6); // Violet-500: Serial Graph Link
  static const Color languageOrange     = Color(0xFFF97316); // Orange-500: Audio Dialect Pill
}
```

---

### 4.3 New Phase 2 Figma Component Specifications

#### Component 1: `GisIsochroneViewport`
* **Dimensions:** `1084px` width × `420px` height.
* **Fill:** Dark satellite/vector map `#090D16` with custom Mapbox/Carto dark basemap tiles.
* **Visual Layers:**
  1. Base street geometry with muted road lines (`#1E293B`).
  2. Outer Isochrone Polygon: Stroke `2px` dashed `Color(0xFF06B6D4)`, fill gradient `0x1A06B6D4`.
  3. Probability Hotspot: Radial blur circle (`#10B981` at 30% alpha) centered on high-confidence sightings.
  4. Unit GPS Pins: Blue pulse indicators for active patrol cars and volunteer K9 handlers.

#### Component 2: `FederationStatusStrip`
* **Dimensions:** Auto-layout `Row`, height `32px`, corner radius `6px`.
* **Sub-Pills:**
  * `[ ✓ POLICE CAD ]` — Green check dot, `#064E3B` fill, `#34D399` text.
  * `[ ✓ TRANSIT AUTH ]` — Blue check dot, `#1E3A8A` fill, `#93C5FD` text.
  * `[ ✓ K9 VOLUNTEER ]` — Cyan check dot, `#164E63` fill, `#67E8F9` text.
  * `[ ⚠ TOLL SYNC ]` — Amber warning dot, `#451A03` fill, `#FCD34D` text.

#### Component 3: `CrossCaseSerialBanner`
* **Dimensions:** `764px` width × `84px` height.
* **Fill:** Obsidian Violet gradient (`#1E1B4B` to `#0F172A`), border `1px solid #8B5CF6`.
* **Icon:** `Icons.hub_rounded` (Purple `#A78BFA`, `20px`).
* **Text Hierarchy:**
  * Header: `"CROSS-CASE SERIAL LINK IDENTIFIED"` (`11px` uppercase bold, `#C4B5FD`).
  * Body: `"Matching White Hatchback (DL-04-XX) flagged in Active Case #CASE-2026-074B"` (`13px`, `#F8FAFC`).
  * Action: Outlined link button `"View Linked Case Graph →"` (`11px`, `#A78BFA`).

#### Component 4: `MultilingualVoicePill`
* **Dimensions:** Auto-layout `Row`, height `26px`, corner radius `999px`.
* **Fill:** `#292524` with border `1px solid #F97316`.
* **Text:** `"🎙 HINDI / EN GLOSSARY ACTIVE"` (`10px` Mono, `#FB923C`).

---

## 5. Summary Slide Text for Pitch Deck Inclusion

When updating Slide 7 of the pitch deck, use the following concise 4-pillar structure:

1. **Tactical GIS Heatmaps (Q2 2026):** Isochrone movement radii calculated from elapsed time, terrain, and vehicle speeds.
2. **Multi-Agency Federation (Q3 2026):** Real-time CAD, Transit, and SAR synchronizations with role-based access control.
3. **Cross-Case Serial Entity Linking (Q4 2026):** Autonomous graph traversal detecting vehicles and MO patterns across neighboring cases.
4. **Multilingual Speech Ingestion (2027):** Real-time transcription and canonical normalization across 20+ regional Indian dialects.

---

*Phase 2 Product & UI Layout Specification completed for DOMINION 2026 Hackathon.*
