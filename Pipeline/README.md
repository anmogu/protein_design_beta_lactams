# TEM-1 Omega-loop Binder Design Pipeline

## Project Goal
Design a de novo protein binder targeting the Glu166-containing O-loop of TEM-1 beta-lactamase (PDB: 1ZG4) to potentially interfere with catalytic activity and antibiotic resistance.

---

## Target
Protein: TEM-1 beta-lactamase
PDB: 1ZG4

Key region:
- Omega-loop (residues 164-179)
- Catalytic hotspot: Glu166
- Supporting hotspot: Asn170

---

## Hotspot Sets

Broad Omega-loop Patch:
A164,A165,A166,A167,A168,A169,A170

Focused Catalytic Patch:
A166,A170,A164,A165

---

## Pipeline

Step 01 - Structural Analysis
- Structural alignment of class A beta-lactamases
- Omega-loop conservation analysis
- Hotspot identification

Step 02 - RFdiffusion
- Generate binder backbones
- Target Omega-loop surface

Step 03 - LigandMPNN
- Sequence optimization
- Interface optimization

Step 04 - RF3 Validation
- pLDDT
- pTM
- iPTM
- PAE analysis

Step 05 - Candidate Selection
- Rank binders
- Select top candidates

---

## Directory Structure

01_Target_Analysis
02_RFdiffusion_Binder_Design
03_LigandMPNN_Sequence_Design
04_RF3_Validation
05_Inputs
06_Results
07_Presentation

