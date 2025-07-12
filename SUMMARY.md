# Project Summary

This project contains a series of analyses on neural data, primarily focused on spike sorting and decoding of visual stimuli. The analyses are divided into four main parts, each corresponding to a Python script.

## Part 1: Spike Sorting (`hw_2_cognitive_science_part_1_code.py`)

This part of the project focuses on identifying and classifying individual neuron spikes from extracellular recordings. The main steps are:

-   **Filtering:** The raw data is filtered to remove noise.
-   **Spike Detection:** Spikes are detected based on a voltage threshold.
-   **Feature Extraction:** Principal Component Analysis (PCA) and t-SNE are used to extract features from the spike waveforms.
-   **Clustering:** K-Means clustering is used to group the spikes into different neuron classes.
-   **Evaluation:** The clustering performance is evaluated using silhouette scores and comparison with ground-truth data.

## Part 2: Spike Sorting (Matlab)

This part of the project is not covered by the Python scripts but appears to be related to spike sorting, as indicated by the `.mat` files (`sort_res_extracellular_sorting_part_2.mat` and `spike_extracellular_detection_part_2.mat`).

## Part 3: Neural Coding of Face Perception (`hw_2_cognitive_science_part_3.py`)

This part of the project analyzes neural data from a face perception experiment. The main steps are:

-   **Firing Rate Calculation:** The firing rate of neurons is calculated in response to different visual stimuli (human faces, monkey faces, and non-faces).
-   **Mutual Information Analysis:** Mutual information is used to quantify the relationship between neural activity and the visual stimuli.
-   **d-prime Analysis:** d-prime is calculated to measure the sensitivity of neurons to different stimuli.
-   **Temporal Analysis:** The onset and peak timings of the neural responses are analyzed.

## Part 4: Decoding of Visual Stimuli (`hw_2_cognitive_science_part_4.py`)

This part of the project focuses on decoding the visual stimuli from the neural responses. The main steps are:

-   **Classifier Training:** Support Vector Machine (SVM) and Linear Discriminant Analysis (LDA) classifiers are trained to distinguish between different stimulus categories.
-   **Performance Evaluation:** The performance of the classifiers is evaluated using accuracy, recall, and F1-score.
-   **Temporal Decoding:** The decoding performance is analyzed over time to understand the temporal dynamics of neural information processing.
-   **Classifier Comparison:** The performance of the SVM and LDA classifiers is compared.
