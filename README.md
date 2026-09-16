# Synthetic Moonquake Generator

**Generation of Synthetic Accelerograms for the Moon Based on the Kanai-Tajimi Methodology**

A research project and standalone MATLAB application for processing, characterizing, and generating synthetic lunar ground motions compatible with the shallow moonquakes recorded by the Apollo Passive Seismic Experiment (PSE).

[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2022a-blue.svg)](https://www.mathworks.com/products/matlab.html)
[![Software Registration](https://img.shields.io/badge/Registration-1--2024--39868-green.svg)]()

---

## Overview

The prospect of permanent lunar settlements requires seismic-resistant design. However, only 74 shallow moonquake events were recorded during the 8-year Apollo PSE mission (1969–1977), and many records are of insufficient quality. This project addresses the scarcity of design records by:

1. **Processing** Apollo LP (Long-Period) seismic records through water-level regularized spectral deconvolution.
2. **Characterizing** the deconvolved records in time and frequency domains using a Kanai-Tajimi filter model and a parametric temporal envelope.
3. **Calibrating** the models with Particle Swarm Optimization (PSO) on 180 shallow moonquake records.
4. **Generating** synthetic accelerograms compatible with the observed seismicity.
5. **Automating** the entire workflow in a standalone MATLAB application with a graphical user interface.

The methodology is documented in a 100+ page user manual and the software is registered with the Colombian copyright office (**Registration No. 1-2024-39868**).

---

## Key Features

### Signal Processing and Deconvolution
- Water-level regularized spectral deconvolution to convert Apollo LP records from Digital Units (DU) to physical ground motion (acceleration, velocity, displacement).
- Butterworth band-pass filtering (8th order) to remove instrumental and environmental noise.
- Hampel filter and detrending for spike removal and baseline correction.
- Validation against published results by Nunn et al. (2022) with 96% NRMSE in amplitude and 97% in PSD.

### Characterization via Particle Swarm Optimization
- Kanai-Tajimi stochastic model adapted to lunar conditions with a custom high-pass/low-pass filter pair.
- Parametric temporal envelope with three regions: power-law growth, plateau, and exponential decay.
- PSO algorithm to calibrate filter parameters (4) and envelope parameters (4) per record.
- Multi-objective cost function weighting time-domain envelope and frequency-domain PSD fit.

### Synthetic Accelerogram Generation
- Band-limited white noise generation with configurable duration and sampling frequency.
- Frequency-domain filtering via the calibrated Kanai-Tajimi transfer function.
- Time-domain windowing with the calibrated envelope.
- PGA scaling to user-defined levels.
- Three magnitude-dependent envelope models: Mw 2.7–3.2, 3.3–3.6, and 3.7–4.1.

### Response Spectrum Computation
- Displacement, velocity, acceleration, pseudo-velocity, and pseudo-acceleration spectra.
- Interpolation-of-excitation method (Chopra, 2012) for numerical efficiency.
- Configurable damping ratio, period range, and gravitational acceleration (lunar g = 1.625 m/s²).

### Graphical User Interface (Synthetic Moonquake Generator)
- Two main tabs: **Synthetic Accelerogram** and **Response Spectrum**.
- Interactive sliders and editable text boxes for all parameters.
- Real-time recalculation and visualization.
- Export to `.fig`, `.txt`, and `.smg` (project file) formats.
- Embedded zoom, pan, cursor, and export controls in every figure.
- File association for `.smg` project files.

---

## Repository Structure
Synthetic-Moonquake-Generator/
├── Code/
│ ├── 01Main/ # Main window figure
│ ├── 02GP/ # White Noise panel
│ ├── 03FP/ # Band-Pass Filter panel
│ ├── 04TP/ # Temporal Envelope panel
│ ├── 05PGA/ # Peak Ground Acceleration panel
│ ├── 06PlotAcc/ # Synthetic Accelerogram plot panel
│ ├── 07ExportAccFig/ # Export Figures button
│ ├── 08ExportAcc/ # Export Accelerogram button
│ ├── 09ZZ/ # Damping Ratio panel
│ ├── 10TN/ # Response Spectrum Periods panel
│ ├── 11GG/ # Gravitational Acceleration panel
│ ├── 12SP/ # Response Spectrum function (SpecMQ.m)
│ ├── 13PlotSpec/ # Response Spectrum plot panel
│ ├── 14ExportSpecFig/ # Export Figures button
│ └── 15ExportSpec/ # Export Spectra button
├── Docs/
│ ├── SMGUserManual.pdf
│ ├── SMGFileAssociation.pdf
│ └── SMGLicenseAgreement.pdf
├── Images/
│ ├── icon48.jpg
│ ├── miniature.jpg
│ └── temporalWindow.jpg
├── SMG.m # Application entry point
└── README.md


---

## Requirements

### Hardware
- 64-bit processor
- 8 GB RAM or more
- 5 GB disk space or more

### Software
- Windows 10 or later
- PDF reader (for the user manual and license documents)
- **MATLAB Runtime R2022a** (included with the installer; MATLAB itself is not required)

---

## Installation

1. Download the installer `SMG.exe`.
2. Right-click and select **Run as administrator**.
3. Follow the installation wizard:
   - Choose installation folder (default: `C:\Program Files\UniValle\SMG`).
   - Accept the MATLAB Runtime license agreement.
   - Wait for MATLAB Runtime installation (if not already present).
4. Click **Finish**.
5. (Optional) Associate `.smg` files with the application:
   - Right-click any `.smg` file → **Open with** → **Choose an app on your PC**.
   - Select `SMG.exe` from the installation directory.
   - Check **Always use this app**.

---

## Usage

### Quick Start
1. Launch `SMG.exe`.
2. The main window opens with the **Synthetic Accelerogram** tab active.
3. Adjust the **White Noise** parameters (event duration, sampling frequency).
4. Design the **Band-Pass Filter** using either:
   - **Observed Values**: sliders for cutoff frequencies and damping ratios.
   - **User Values**: Butterworth filter order (1–4) and cutoff frequencies.
5. Select a **moment magnitude range** in the **Temporal Envelope** panel:
   - 2.7–3.2, 3.3–3.6, or 3.7–4.1.
6. Set the desired **PGA** (Peak Ground Acceleration).
7. View the results in the six-plot panel.
8. Switch to the **Response Spectrum** tab to compute response spectra.
9. Export figures (`.fig`) or data (`.txt`) as needed.

### Example: Generate a Synthetic Moonquake

White Noise → Event Duration: 85 min, Sampling Frequency: 100 Hz

Band-Pass Filter → High-pass: 0.432 Hz, ζ = 12.136; Low-pass: 33.333 Hz, ζ = 0.072

Temporal Envelope → Select "2.7 to 3.2" magnitude range

PGA → 1.000 m/s²

Export Accelerogram → Save as MQ001.txt


---

## Methodology

### 1. Data Source
- **Apollo Passive Seismic Experiment (PSE)** records from the DARTS database (ISAS/JAXA).
- 28 shallow moonquake events, horizontal LP components (LPX, LPY).
- Records in Digital Units (DU), 10-bit resolution, nominal sampling rate ~6.625 Hz.

### 2. Deconvolution
- Apollo LP seismometer modeled as a Linear Time-Invariant (LTI) system.
- Water-level regularization (Horvath, 1979) to handle spectral zeros and noise amplification.
- Water level `ω = k · max|TF(s)|` with `k = 0.10`.
- Limit frequency: 0.7655 Hz for `k = 0.10`.
- Verification: 96% NRMSE in amplitude, 97% in PSD.

### 3. Characterization
- **Filter model**: Kanai-Tajimi with a high-pass and low-pass Butterworth pair.
  - Parameters: `fh, zh, fg, zg` (cutoff frequencies and damping ratios).
- **Envelope model**: Three-region temporal window.
  - Parameters: `t1, a, t2, c` (rise time, rise exponent, fall time, fall exponent).
- **Optimization**: Particle Swarm Optimization (PSO) with 40 particles, 200 iterations max, 16,000 synthetic accelerograms evaluated.
- **Objective function**: Weighted combination of NRMSE in time envelope and PSD (weights: `[0 0 0.5 1 1 0 1 0] / sum`).

### 4. Synthesis
- Band-limited white noise → Kanai-Tajimi filter → temporal envelope → PGA scaling.
- Three envelope models by moment magnitude range.

---

## Results

### Deconvolution
- Successfully deconvolved LP records to acceleration, velocity, and displacement.
- Comparison with Nunn et al. (2022) shows good agreement within the 0.30–0.7655 Hz band.

### Characterization
- Average NRMSE: 80% in temporal envelope, 55% in PSD.
- Frequency range of interest: 0.15–0.80 Hz.

### Synthetic Accelerograms
- Three magnitude-dependent models with mean parameters:

| Mw Range   | t1 [%] | a [-] | t2 [%] | c [-] |
|------------|--------|-------|--------|-------|
| 2.7 – 3.2  | 10.35  | 1.62  | 12.21  | -3.10 |
| 3.3 – 3.6  |  8.48  | 0.74  |  9.54  | -3.21 |
| 3.7 – 4.1  |  6.09  | 1.00  |  8.74  | -4.85 |

---

## Publication

**Preliminary Approach to Assess the Seismic Hazard on the Moon.**
Cadena, P. et al., *CONIITI*, 2020.
DOI: [10.1109/CONIITI51147.2020.9240257](https://doi.org/10.1109/CONIITI51147.2020.9240257)

---

## Acknowledgments

- **Daniel Gómez Pizano, PhD** and **Alejandro Cruz Escobar, MSc** — co-directors of this work at Universidad del Valle.
- **Universidad del Valle** — internal research project 21078.
- **ISAS/JAXA** — DARTS database for providing Apollo seismic records.
- **NASA** — Apollo mission data and documentation.

This research made use of data obtained from the Data ARchives and Transmission System (DARTS), provided by the Center for Science-satellite Operation and Data Archive (C-SODA) at ISAS/JAXA.

---

## Author

**Oscar Alejandro Arcila Giraldo**
- [LinkedIn](https://co.linkedin.com/in/oscar-alejandro-arcila-giraldo-94294a41a)
- [GitHub](https://github.com/OscarAArcilaG)
- [ORCID](https://orcid.org/0009-0008-9379-4343)
- [ResearchGate](https://www.researchgate.net/profile/Oscar-Arcila-Giraldo)

---

## License

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

Software registration: **No. 1-2024-39868** (Colombian copyright office).

---

## References

- Chopra, A. (2012). *Dynamics of Structures: Theory and Applications to Earthquake Engineering* (4th ed.). Prentice Hall.
- Clough, R. & Penzien, J. (2003). *Dynamics of Structures* (3rd ed.). Computers and Structures Inc.
- Horvath, P. (1979). *Analysis of Lunar Seismic Signals: Determination of Instrumental Parameters and Seismic Velocity Distributions* (Dissertation). Texas University.
- Kanai, K. (1957). Semi-empirical Formula for the Seismic Characteristics of Ground. *Transactions of the Architectural Institute of Japan*.
- Nakamura, Y., Latham, G., Dorman, H., & Harris, J. (1981). *Passive Seismic Experiment, Long Period Event Catalog*. University of Texas Institute for Geophysics.
- Nunn, C. et al. (2020). Lunar Seismology: A Data and Instrumentation Review. *Space Science Reviews*, 216(5), 89.
- Nunn, C., Nakamura, Y., Kedar, S., & Panning, M. P. (2022). A New Archive of Apollo's Lunar Seismic Data. *The Planetary Science Journal*, 3(9), 219.
- Tajimi, H. (1960). A Statistical Method of Determining the Maximum Response of a Building Structure during an Earthquake. *Proceedings of the 2nd World Conference on Earthquake Engineering*.
- Yamada, R. (2005). *The Apollo Seismometer Responses*. DARTS.
