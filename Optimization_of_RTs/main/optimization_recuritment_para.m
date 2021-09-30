% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Parameters setting part

% Loading input constants (MU centers, MF centers and other essential constants)
clear all
load('\\icnas4.cc.ic.ac.uk\dl1920\Project\MUAP_optimization_recuritment-main\opti_rr_inti.mat') 
% To load intial cosntants, please add opti_rr_inti.mat to workspace

% Optimization Mode Choose
fprintf('--------Optimization Mode Choose--------\n');
optiz_mode = input('Please input optimization method (Genetic Algorithm --- 1): ');

if optiz_mode == 1 % Genetic Algorithm
    tic
	% Set parameters range
    rr_range=[0;100];
    rm_range=[0;1];
	
	% Set parameters of optimizator
    sample_size=50;
    mate_number=3;
    generation_num=200;
    adding_sample=10;
    variation_rate=0.1;
    
	% Run main body of genetic algorithm
    run genetic_algorithm
    time_opti=toc;
    
else % illegual input
    error('The choose for optimization method must 1');
end

% Plot Part
% run plot_mf_assignment
% run plot_mf_assignment_visiable
% run plot_muap
