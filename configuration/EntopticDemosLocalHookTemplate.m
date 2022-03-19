function EntopticDemosLocalHook
% Configure paths and preferences for EntopticDemos
%
% This local hook is for use with the ToolboxToolbox.  If you copy this
% into your ToolboxToolbox localToolboxHooks directory (by default,
% ~/localToolboxHooks) and delete "LocalHooksTemplate" from the filename,
% this will get run when you execute
%   tbUseProject('OLApproach_Psychophysics')
% to set up for this project.  You then edit your local copy to match your
% local machine.

%% Say hello
fprintf('Running EntopticDemos local hook\n');
approach = 'EntopticDemos';
approachPath = fullfile(tbLocateProject(approach));

%% Set MATLAB preferences
% Remove old preferences
if (ispref(approach))
    rmpref(approach);
end

% Set path preferences
calBasePath = '~/Desktop/EntopticDemosMaterials';
setpref(approach, 'OneLightCalDataPath', calBasePath);

% Overwrite OneLightToolbox preference for calibrations
setpref('OneLightToolbox','OneLightCalData',getpref(approach,'OneLightCalDataPath'));

%% Set simulate.
simulate.oneLight = true;
simulate.radiometer = true;
simulate.projector = true;
simulate.gamepad = true;
setpref(approach,'simulate',simulate);

%% Set the default speak rate
setpref(approach, 'SpeakRateDefault', 230);

%% Add OmniDriver.jar to java path
OneLightDriverPath = tbLocateToolbox('OneLightDriver');
JavaAddToPath(fullfile(OneLightDriverPath,'xOceanOpticsJava/OmniDriver.jar'),'OmniDriver.jar');