# Repository Structure

This repository is divided into two completely separate parts.

## 1. Course Material

```text
27666_Protein_Design/
```

This is a copy of the original DTU course repository.

Purpose:
- lecture material
- notebooks
- examples
- reference workflows

These files should remain unchanged whenever possible.

---

## 2. Research Pipeline

```text
Pipeline/
```

This contains all files created for the TEM-1 binder design project.

Current structure:

```text
Pipeline/
│
├── 01_Target_Analysis
├── 02_RFdiffusion_Binder_Design
│   ├── configs
│   │   └── TEM1_1ZG4_rfd3.json
│   └── scripts
│       └── submit_rfd3.sh
│
├── 03_LigandMPNN_Sequence_Design
├── 04_RF3_Validation
├── 05_Inputs
│   └── 1ZG4_clean.pdb
│
├── 06_Results
├── 07_Presentation
└── README.md
```

---

# Files Created So Far

## 1ZG4_clean.pdb

Location:

```text
Pipeline/05_Inputs/
```

Purpose:

Input structure used by RFdiffusion.

To work on a different protein:

- replace this PDB
- update the path inside the JSON configuration

---

## TEM1_1ZG4_rfd3.json

Location:

```text
Pipeline/02_RFdiffusion_Binder_Design/configs/
```

Purpose:

Defines the RFdiffusion design task.

Contains:

- input PDB
- target chain
- hotspot residues
- contig definition
- binder length
- orientation strategy

To design a different binder:

- change hotspot residues
- change contig
- change binder length
- optionally change target PDB

This is the main file that controls the design.

---

## submit_rfd3.sh

Location:

```text
Pipeline/02_RFdiffusion_Binder_Design/scripts/
```

Purpose:

Launches RFdiffusion on DTU HPC.

Contains:

- GPU request
- memory request
- RFdiffusion command
- checkpoint path
- output folders

For a new experiment:

- update experiment directory
- update JSON path
- keep checkpoint path unchanged

---

# DTU HPC Workflow

## Activate Environment

```bash
source /dtu/blackhole/00/c27666/miniforge3/etc/profile.d/conda.sh

conda activate protein-design
```

---

## Create Experiment Folder

Example:

```bash
mkdir -p $BLACKHOLE/TEM1_1ZG4/exp_01/{configs,inputs,diffusion_out,mpnn_out,rf3_out,scores}
```

---

## Copy Files To HPC

### Copy PDB

```powershell
scp "LOCAL_PDB_FILE" \
s250828@login1.hpc.dtu.dk:/dtu/blackhole/12/220114/TEM1_1ZG4/exp_01/inputs/
```

### Copy JSON

```powershell
scp "LOCAL_JSON_FILE" \
s250828@login1.hpc.dtu.dk:/dtu/blackhole/12/220114/TEM1_1ZG4/exp_01/configs/
```

### Copy Submission Script

```powershell
scp "LOCAL_SCRIPT" \
s250828@login1.hpc.dtu.dk:/dtu/blackhole/12/220114/TEM1_1ZG4/exp_01/
```

---

## Verify Files

```bash
ls inputs
ls configs
```

---

## Test RFdiffusion Configuration

Run on CPU first to verify that:

- PDB path exists
- hotspot residues exist
- contig is valid

```bash
rfd3 design \
  out_dir=/tmp/test_run \
  inputs=configs/TEM1_1ZG4_rfd3.json \
  ckpt_path=~/.foundry/checkpoints/rfd3_latest.ckpt \
  diffusion_batch_size=1 \
  n_batches=1
```

If the configuration is valid, the program should proceed until it complains about missing GPU/CUDA.

This confirms that the JSON and PDB are accepted.

---

## Submit Real GPU Job

```bash
cd /dtu/blackhole/12/220114/TEM1_1ZG4/exp_01

bsub < submit_rfd3.sh
```

---

## Check Queue

```bash
bjobs
```

Possible states:

```text
PEND
RUN
DONE
```

---

## Monitor Logs

```bash
tail -f rfd3_*.out
```

```bash
tail -100 rfd3_*.err
```

---

# Creating New Designs

For a new target or experiment:

1. Create a new experiment folder

```text
TARGET_NAME/exp_01
```

2. Copy a new PDB into:

```text
inputs/
```

3. Copy and modify the JSON:

```text
configs/
```

4. Update:
   - input path
   - hotspot residues
   - contig
   - binder length

5. Update paths inside:

```text
submit_rfd3.sh
```

6. Copy files to Blackhole

7. Run validation test

8. Submit GPU job

The only file that usually needs substantial editing is:

```text
TEM1_1ZG4_rfd3.json
```

Everything else is mostly path management.