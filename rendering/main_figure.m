clear;clc;close all

% Define the relative path to the datafile directory
datafileDir = fullfile('..', 'mag_tube_after' ,'datafiles');

% Get all .txt files in the directory
txtFiles = dir(fullfile(datafileDir, '*.txt'));

% Construct the full path for the current file
filePath = fullfile(datafileDir, txtFiles.name);

% Display the filename (optional)
fprintf('Reading file: %s\n', filePath);

% Read the file (modify based on file content)
data = readmatrix(filePath);
   
% Extract the first column (time)
timeColumn = data(:, 1);

% Find unique times and their counts
[uniqueTimes, ~, timeIndices] = unique(timeColumn);

% Number of nodes is the count of rows for the first unique time
numNodes = sum(timeIndices == 1);
numSteps = length(timeColumn) / numNodes;

figure(1)
% title('Smooth Rod');
xlabel('X');
ylabel('Y');
zlabel('Z');


% Initialize parameters
tubeNv = 400; % Number of vertices (replace with your actual value)
deltaLen = 2 * pi / (10 * tubeNv);

% Preallocate the matrix to store tubeNode data
tubeNode = zeros(tubeNv, 3); % Assuming 3 columns for x, y, z coordinates

% Populate the tubeNode matrix
for i = 1:tubeNv
    tubeNode(i, 1) = deltaLen * i; % x-coordinate
    tubeNode(i, 2) = 0.1 * cos(deltaLen * 10 * i) - 0.1; % y-coordinate
    tubeNode(i, 3) = 0.0; % z-coordinate
end

renderTube(tubeNode(:,1), tubeNode(:,2), tubeNode(:,3), 'vessel')
hold on

axe_length = 0.75;
grid on;
axis equal
axis off
view(45,45)
camlight('headlight');  % Add default headlight for better visualization
% light('Position', [1.0 1.0 1.0], 'Style', 'infinite', 'Color', [0.5, 0.5, 0.5]);  % Light source in positive z-axis
lighting phong;


% xlim([-axe_length/2,axe_length/2])
% ylim([-axe_length/2,axe_length/2])
% zlim([-axe_length/2,axe_length/2])

for i = 1:18:numSteps
    
    startIndex = numNodes * (i - 1) + 1;
    endIndex = numNodes * i;
    
    x = data(startIndex:endIndex, 2);
    y = data(startIndex:endIndex, 3);
    z = data(startIndex:endIndex, 4); 

    renderTube(x, y, z, 'wire')

    
    % legend('Blood vessel', 'Guidewire', 'Magnetized head')

    exportgraphics(gcf, 'sim_after.gif', "Append",true, 'Resolution',300)  % 300 DPI
    % drawnow
end

