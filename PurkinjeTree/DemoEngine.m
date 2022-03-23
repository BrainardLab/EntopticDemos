function DemoEngine(trialList,oneLight,varargin)
%%Demo  Simple program for demo of pulses
%
% Description:
%    Simple program for demo of pulses
%
% Optional key/value pairs:
%    verbose (logical)         true       Be chatty?

% 7/7/16    ms      Wrote it.
% 7/28/17   dhb     Pass ol object

%% Parse
p = inputParser;
p.addRequired('trialList');
p.addRequired('oneLight',@(x) isa(x,'OneLight'));
p.addParameter('verbose',true,@islogical);
p.addParameter('speakRate',320,@isscalar);
p.parse(trialList, oneLight, varargin{:});

speakRate = p.Results.speakRate;

%% Run trialList
fprintf('<strong>Demo started</strong>\n');
for trialNum = 1:numel(trialList)
    trial = trialList(trialNum);
    fprintf('Stimulus: <strong>%s</strong>\n', trial.name);
    
    % Adapt to background
    oneLight.setMirrors(trial.backgroundStarts, trial.backgroundStops);
    Speak(sprintf('Adapt to background for %g seconds.', trial.adaptTime), [], speakRate);
    mglWaitSecs(trial.adaptTime);
    Speak('Adaptation complete', [], speakRate);
    fprintf('Done.\n');
    
    % Show N repeats of stimulus
    fprintf('Showing %d stimulus repeats, ctrl-C to exit\n',trial.repeats);
    Speak('Showing trials.',[], speakRate);

    for R = 1:trial.repeats
        fprintf('Trial %d of %d\n',R,trial.repeats)
        oneLight.setMirrors(trial.backgroundStarts, trial.backgroundStops);
        OLFlicker(oneLight, trial.modulationStarts, trial.modulationStops, trial.timestep, 1);
        if (CharAvail)
            GetChar;
            break;
        end
    end
    fprintf('Done.\n')
end

%% Inform user that we are done
Speak('End of demo.', [], speakRate);