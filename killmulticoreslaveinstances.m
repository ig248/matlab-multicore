function killmulticoreslaveinstances(multicoreDir)
%KILLMULTICORESLAVEINSTANCES  Kill slaves associated with multicoreDir
%
%   Igor Gotlibovych
%   Last modified 20.07.2014
%
%   See also STARTMULTICORESLAVEINSTANCES.
import multicore.*

% get slave file directory name
if ~exist('multicoreDir', 'var') || isempty(multicoreDir)
  multicoreDir = fullfile(tempdir2, 'multicorefiles');
end

rmdir(multicoreDir, 's')
end