%% Simulate Fuzzy Inference System
% Once you have implemented a fuzzy inference system using *Fuzzy Logic
% Designer*, using *Neuro-Fuzzy Designer*, or at the command line, you can
% simulate the system in Simulink.

%%
% For this example, you control the level of water in a tank using a fuzzy
% inference system implemented using a Fuzzy Logic Controller block. Open
% the |sltank| model.
open_system('sltank')

%%
% For this system, you control the water that flows into the tank using a
% valve. The outflow rate depends on the diameter of the output pipe, which
% is constant, and the pressure in the tank, which varies with water level.
% Therefore, the system has nonlinear characteristics.
%
% The two inputs to the fuzzy system are the water level error, |level|,
% and the rate of change of the water level, |rate|. The output of the
% fuzzy system is the rate at which the control valve is opening or
% closing, |valve|.
%
% To implement a fuzzy inference system, specify the *FIS name* parameter
% of the Fuzzy Logic Controller block as the name of a FIS object in the
% MATLAB(R) workspace. In this example, the block uses the |mamfis| object
% |tank|.
%
% For more information on this system, see
% <docid:fuzzy.mw_b1c6a4d2-e398-4fb7-b95e-6ead41d6880f>.

%%
% As a first attempt to control the water level, set the following rules in
% the FIS. These rules adjust the valve based on only the water level
% error.
%
% * If the water level is okay, then do not adjust the valve.
% * If the water level is low, then open the valve quickly.
% * If the water level is high, then close the valve quickly.
%
% Specify the rules by creating a vector of |fisrule| objects and assigning
% it to the |Rules| property of the |tank| FIS object.
rule1 = "If level is okay then valve is no_change";
rule2 = "If level is low then valve is open_fast";
rule3 = "If level is high then valve is close_fast";
rules = [rule1 rule2 rule3];
tank.Rules = fisrule(rules);

%%
% Simulate the model, and view the water level.
open_system('sltank/Comparison')
sim('sltank',100)

%%
% These rules are insufficient for controlling the system, since the water
% level oscillates around the setpoint.
% 
% To reduce the oscillations, add two more rules to the system. These rules
% adjust the valve based on the rate of change of the water level when the
% water level is near the setpoint.
%
% * If the water level is okay and increasing, then close the valve slowly.
% * If the water level is okay and decreasing, then open the valve slowly.
%
% To add these rules, use the |addRule| function.
rule4 = "If level is okay and rate is positive then valve is close_slow";
rule5 = "If level is okay and rate is negative then valve is open_slow";
newRules = [rule4 rule5];
tank = addRule(tank,newRules);

%%
% Simulate the model.
sim('sltank',100)

%%
% The water level now tracks the setpoint without oscillating.

%%
% You can also simulate fuzzy systems using the Fuzzy Logic Controller with
% Ruleviewer block. The |sltankrule| model is the same as the |sltank|
% model, except that it uses the Fuzzy Logic Controller with Ruleviewer
% block.
open_system('sltankrule')

%%
% During simulation, this block displays the Rule Viewer from the *Fuzzy
% Logic Designer* app.
sim('sltankrule',100)

%%
% If you pause the simulation, you can examine the FIS behavior by manually
% adjusting the input variable values in the Rule Viewer, and observing the
% inference process and output.
%
% You can also access the *Fuzzy Logic Designer* editors from the Rule
% Viewer. From the Rule Viewer, you can then adjust the parameters of your
% fuzzy system using these editors, and export the updated system to the
% MATLAB workspace. To simulate the updated FIS, restart the simulation.
% For more information on using these editors, see <docid:fuzzy.FP243DUP9>.

% Copyright 2017 The MathWorks, Inc.

