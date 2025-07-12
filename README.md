# Cognitive Science Homework 2

This repository contains the code and data for a cognitive science homework assignment. The project involves analyzing neural data to understand spike sorting and the neural coding of visual stimuli.

## Project Overview

The project is divided into four main parts:

1.  **Spike Sorting:** Identifying and classifying individual neuron spikes from extracellular recordings.
2.  **Spike Sorting (Matlab):** Further spike sorting analysis (not covered in the Python scripts).
3.  **Neural Coding of Face Perception:** Analyzing neural responses to different visual stimuli (faces and non-faces).
4.  **Decoding of Visual Stimuli:** Using machine learning to decode the visual stimuli from the neural responses.

A more detailed summary of the analyses can be found in `SUMMARY.md`.

## Data Files

The following data files are used in the analyses:

-   `extracellular.mat`: Extracellular recordings for spike sorting.
-   `spikes.mat`: Ground-truth spike indices for the spike sorting task.
-   `sort_res_extracellular_sorting_part_2.mat`: Results from the Matlab-based spike sorting.
-   `spike_extracellular_detection_part_2.mat`: Spike detection results from the Matlab-based analysis.
-   `assignment2-face-data.npy`: Neural recordings from the face perception experiment.
-   `assignment2-face-data-labels.npy`: Labels for the face perception data.

## Running the Code

The analyses are performed in Python, and the code is provided in the following scripts:

-   `hw_2_cognitive_science_part_1_code.py`
-   `hw_2_cognitive_science_part_3.py`
-   `hw_2_cognitive_science_part_4.py`

### Dependencies

The following Python libraries are required to run the code:

-   numpy
-   scipy
-   matplotlib
-   scikit-learn
-   pandas

You can install these dependencies using pip:

```
pip install numpy scipy matplotlib scikit-learn pandas
```

### Usage

The Python scripts can be run from the command line:

```
python hw_2_cognitive_science_part_1_code.py
python hw_2_cognitive_science_part_3.py
python hw_2_cognitive_science_part_4.py
```

Please note that the scripts were originally created as Jupyter Notebooks and may contain some non-standard Python code (e.g., HTML formatting).

## Summary of Results

The analyses in this project yield several key findings:

-   **Spike Sorting:** The spike sorting analysis successfully identifies and classifies different neuron spikes from the extracellular recordings. The performance of the clustering algorithm is evaluated using various metrics.
-   **Neural Coding:** The analysis of the face perception data reveals that neurons in the studied brain region exhibit selective responses to different visual stimuli. The mutual information and d-prime analyses quantify this selectivity.
-   **Decoding:** The machine learning classifiers are able to decode the visual stimuli from the neural responses with a high degree of accuracy. The temporal analysis of the decoding performance provides insights into the time course of neural information processing.

For a more detailed description of the results, please refer to the individual Python scripts and the `SUMMARY.md` file.
