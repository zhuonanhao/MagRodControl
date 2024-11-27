%% Clear cache
clear;clc;close all

%% Initilize the figure
FONT = 'Arial';
FONTSIZE = 10;
pWidth = 7; % inches
pHeight = pWidth * 3/4;

%% Extract data and plot
% Define the relative path to the datafile directory
datafileDir = fullfile('simFiles' ,'case3');

% Get all .txt files in the directory
rodFiles = dir(fullfile(datafileDir, 'simDER_time*.txt'));
tubeFile = dir(fullfile(datafileDir, 'tube.txt'));

% Construct the full path for the current file
filePath = fullfile(datafileDir, tubeFile.name);

% Read the file (modify based on file content)
data = readmatrix(filePath);

x_tube = data(:, 1);
y_tube = data(:, 2);
z_tube = data(:, 3); 

h = figure(1);
axes_length = 0.25;

% Predefine axis limits and view angle
xLimits = [-axes_length, axes_length]; % Adjust as needed
yLimits = [-axes_length, axes_length]; % Adjust as needed
zLimits = [-axes_length, axes_length]; % Adjust as needed
viewAngle = [45, 45]; % Azimuth and elevation

% Case 1
xLimits = [-0.8, 0.25]; % Adjust as needed
yLimits = [-0.05, 0.45]; % Adjust as needed
zLimits = [-0.05, 0.05]; % Adjust as needed
viewAngle = [45, 45]; % Azimuth and elevation

% Case 2
xLimits = [-0.6, 0.6]; % Adjust as needed
yLimits = [-0.25, 0.05]; % Adjust as needed
zLimits = [-0.05, 0.05]; % Adjust as needed
viewAngle = [45, 45]; % Azimuth and elevation

% Case 3
xLimits = [-0.8, 0.15]; % Adjust as needed
yLimits = [-0.05, 0.25]; % Adjust as needed
zLimits = [-0.05, 0.2]; % Adjust as needed
viewAngle = [45, 10]; % Azimuth and elevation

for i = 1:length(rodFiles)

    subplot(2, length(rodFiles)/2,i)
    hold on

    splitStr = split(rodFiles(i).name, '_');
    timePart = splitStr{3};
    time = erase(timePart, '.txt');
    time = str2double(time);
    
    % Construct the full path for the current file
    filePath = fullfile(datafileDir, rodFiles(i).name);
    
    % Read the file (modify based on file content)
    data = readmatrix(filePath);
    
    x = data(:, 1);
    y = data(:, 2);
    z = data(:, 3); 
    
    renderTubeFig(x_tube, y_tube, z_tube, 'vessel')
    renderTubeFig(x, y, z, 'wire')

    title(sprintf('Time = %.2f', time), 'interpreter', 'latex', 'FontSize', FONTSIZE)
    
    view(viewAngle)
    camlight('headlight');  % Add default headlight for better visualization
    lighting phong;

    axis equal
    axis([xLimits, yLimits, zLimits]) % Set fixed axis limits
    axis off
    hold off
end

%% Save the figure
set(gca, 'FontName', FONT, 'FontSize', FONTSIZE, 'TickLabelInterpreter','latex');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 pWidth pHeight], ...
    'PaperSize', [pWidth pHeight]);

%% Save the figure
% saveas(h, '1.pdf');
print(h, '3.pdf', '-dpdf', '-r900');  % Change '-r300' to higher DPI if needed
