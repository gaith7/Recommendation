% Train ANN 

clear;clc;

Max_Training_round=30;            % Maximum round # to train ANN

% Neural network training setting
ANN_L1=3; ANN_L2=2; % ANN layer 1 and 2 neuron numbers % ##################
ANN_Max_Epochs=500;

%% Load the auto data
NF=12; % number of failure history considered. 
M = dlmread('CloudCompute.txt', '\t');
load M;

Training_History=[1,2,4,5,7]; % Failure histories for training % ##################
% ===================================================================
NS=187;                              % number of advisor considered. 





