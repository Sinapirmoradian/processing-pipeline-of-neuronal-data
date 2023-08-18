% Load the data from the .mat file
data = load('extracellular.mat');
voltages = data.all_data_with_noise_and_line(1,:); % extract the voltage amplitude data from the structure

% Create a time axis based on the sampling rate of 2400Hz
Fs = 2400;
Ts = 1/Fs;
t = linspace(0,Ts*length(voltages),length(voltages));

% Plot the voltage amplitude against time
figure;
plot(t, voltages);
xlabel('Time (s)');
ylabel('Voltage Amplitude');

% Plot the histogram of the voltage amplitudes
figure;
histogram(voltages, 'BinWidth', 0.1);
xlabel('Voltage Amplitude');
ylabel('Count');

% Set the filter specifications
Fs = 2400; % Hz
Fn = Fs/2; % Hz
Fc = 300; % Hz
Wn = Fc/Fn;

% Design the highpass Butterworth filter
N = 7;
[b, a] = butter(N, Wn, 'high');

% Apply the filter using filtfilt
filtered_voltages = filtfilt(b, a, voltages);

% Plot the filtered and unfiltered voltage signals
subplot(3,1,1);
plot(t, filtered_voltages);
ylabel('Filtered Voltage');
subplot(3,1,2);
plot(t, voltages);
ylabel('Unfiltered Voltage');

% Plot the histogram of the filtered voltage amplitudes
subplot(3,1,3);
histogram(filtered_voltages, 'BinWidth', 0.1);
xlabel('Voltage Amplitude');
ylabel('Count');

% Set the threshold for spike detection
sigma_n = median(abs(filtered_voltages))/0.6745;
tht = 5 * sigma_n;

% Plot the threshold and filtered voltage signal
figure;
plot(t, filtered_voltages);
hold on;
plot(t, tht * ones(size(filtered_voltages)), 'r');
xlabel('Time (s)');
ylabel('Voltage Amplitude');
legend('Filtered Voltage', 'Threshold');

% Detect the peaks in the filtered voltage signal
peak_indices = find(filtered_voltages >= tht);

% Create a matrix of spikes, where each row is a spike and the columns are the voltage values around the peak
number_of_samples = 2 * ceil(2e-3/Ts);
spike_matrix = zeros(length(peak_indices), number_of_samples);
for i = 1:length(peak_indices)
    for j = 1:number_of_samples
        spike_matrix(i,j) = filtered_voltages(peak_indices(i) - (number_of_samples/2) + j);
    end
end

% Perform PCA on the spike matrix to extract features
[coeff, score, latent, ~, explained] = pca(spike_matrix);

% Plot the 3D scatter plot of the first 3 principal components
figure;
scatter3(score(:,1), score(:,2), score(:,3), 'filled');
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
zlabel('3rd Principal Component');
title('PCA Scatter Plot');

% Cluster the spikes using k-means
num_clusters = 5;
[idx, C] = kmeans(score(:,1:3), num_clusters);

% Plot the 2D scatter plots of the first and second, first and third, and second and third principal components, with each cluster shown in a different color
figure;
gscatter(score(:,1), score(:,2), idx);
hold on;
plot3(C(:,1), C(:,2), C(:,3), 'kx')
% Add labels to the plot
xlabel('First Principal Component');
ylabel('Second Principal Component');
title('2D Scatter Plot of First and Second Principal Components');

% Plot the 2D scatter plot of the first and third principal components
figure;
gscatter(score(:,1), score(:,3), idx);
hold on;
plot3(C(:,1), C(:,2), C(:,3), 'kx')
xlabel('First Principal Component');
ylabel('Third Principal Component');
title('2D Scatter Plot of First and Third Principal Components');

% Plot the 2D scatter plot of the second and third principal components
figure;
gscatter(score(:,2), score(:,3), idx);
hold on;
plot3(C(:,1), C(:,2), C(:,3), 'kx')
xlabel('Second Principal Component');
ylabel('Third Principal Component');
title('2D Scatter Plot of Second and Third Principal Components');

% Display the explained variance ratio of each principal component
% explained_ratio = pca_model.ExplainedVarianceRatio;
disp('Explained variance ratio of each principal component:');
disp(explained);

% Display the cumulative explained variance ratio of the principal components
cumulative_explained_ratio = cumsum(explained);
disp('Cumulative explained variance ratio of the principal components:');
disp(cumulative_explained_ratio);

% Plot the cumulative explained variance ratio as a function of the number of principal components
figure;
plot(1:length(cumulative_explained_ratio), cumulative_explained_ratio, 'bo-');
xlabel('Number of Principal Components');
ylabel('Cumulative Explained Variance Ratio');
title('Cumulative Explained Variance Ratio vs. Number of Principal Components');
grid on;

% Determine the optimal number of principal components to retain based on the cumulative explained variance ratio
threshold = 0.95;
optimal_num_components = find(cumulative_explained_ratio >= threshold, 1, 'first');
disp(['Optimal number of principal components to retain: ', num2str(optimal_num_components)]);

% Part 1: PCA Analysis and Clustering
%% Load Data
load('spikes.mat');

%% Perform PCA Analysis
[coeff,score,T] = pca(spike_matrix); % principal component analysis

%% Plot PCA Results
figure;
scatter3(score(:,1),score(:,2),score(:,3), 'filled');
axis equal;
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
zlabel('3rd Principal Component');

figure;
biplot(coeff(:,1:3),'scores',score(:,1:3));
title('PCA Analysis');

pca_components = score(:,1:3); % create 3-component PCA

%% Cluster Data with k-means
for k = 3:6
    idx = kmeans(pca_components, k);
    
    % Plot results
    figure;
    gscatter(pca_components(:,1),pca_components(:,2),idx);
    legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6');
    xlabel('1st Principal Component');
    ylabel('2nd Principal Component');
    
    figure;
    gscatter(pca_components(:,1),pca_components(:,3),idx);
    legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6');
    xlabel('1st Principal Component');
    ylabel('3rd Principal Component');
    
    figure;
    gscatter(pca_components(:,2),pca_components(:,3),idx);
    legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6');
    xlabel('2nd Principal Component');
    ylabel('3rd Principal Component');
    
    figure;
    scatter3(pca_components(:,1),pca_components(:,2),pca_components(:,3), 15, idx, 'filled');
    axis equal;
    xlabel('1st Principal Component');
    ylabel('2nd Principal Component');
    zlabel('3rd Principal Component');
end
% Part 2: Apply a New Threshold to Identify Spikes
%% Load Data
load('spikes.mat');

%% Apply New Threshold to Identify Spikes
new_sigma_n = max(filtered_voltages);
new_tht = 0.9*new_sigma_n; % create new threshold 0.9*max(x_t)
new_theta = repmat(new_tht, 1, length(filtered_voltages));

figure;
plot(t,filtered_voltages);
hold on;
plot(t,new_theta,'r');
new_cnt = 0;
for i = 1:length(filtered_voltages)
    if filtered_voltages(1,i) >= new_tht
        new_cnt = new_cnt + 1;
        new_matrix_spike_peak_index(new_cnt) = i;
    end
end
number_of_sample = 2 * ceil(2e-3/Ts);
new_matrix_spikes = zeros(new_cnt, number_of_sample);
for i = 1:length(new_matrix_spike_peak_index)
    for j = 1:number_of_sample
        new_matrix_spikes(i,j) = filtered_voltages(1, new_matrix_spike_peak_index(i)-1+j);
    end
end
