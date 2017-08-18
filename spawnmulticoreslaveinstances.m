function multicoreDir = spawnmulticoreslaveinstances(n, multicoreDir, settings)
%STARTMULTICORESLAVEINSTANCES  Start multi-core processing slave processes in new MATLAB instances.
%
%   Igor Gotlibovych
%   Last modified 20.07.2014
%
%   See also STARTMULTICORESLAVE.
import multicore.*

if ~exist('n', 'var') || isempty(n)
  %n = str2num(getenv('NUMBER_OF_PROCESSORS')) - 1;
  n = feature('numCores') - 1;
end
% get slave file directory name
if ~exist('multicoreDir', 'var') || isempty(multicoreDir)
  multicoreDir = fullfile(tempdir2, 'multicorefiles');
end
if ~exist(multicoreDir, 'dir')
  try
    mkdir(multicoreDir);
  catch
    error('Unable to create slave file directory %s.', multicoreDir);
  end
end

if ~exist('settings', 'var')
  % use default settings
  settings = [];
end

% get path to multicore on this machine
wat = what('multicore');
packagepath = wat.path;

timestamp = num2str(randi(9999));  %FIXME
settingsfile = fullfile(multicoreDir, ['settings' timestamp '.mat']);
save(settingsfile, 'settings', 'multicoreDir', 'packagepath');

for i = 1:n
    command = [
        'matlab -nosplash -nodesktop  -minimize -noFigureWindows -r "' ...
        'disp(''Starting Slave ' num2str(i) ''');'... 
        'load(''' settingsfile ''');'...
        'cd(fullfile(packagepath, ''..''));'...
        'multicore.startmulticoreslave;'...
        'quit()'...
        '" &'
        ];
    [status, cmdout] = system(command);
    fprintf('Slave %d/%d returned status %d: %s\n', i, n, status, cmdout);
end
end