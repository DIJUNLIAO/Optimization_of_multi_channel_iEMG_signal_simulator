% Optimization of electrode position
% Intial optimization parameters generate and import Part

clear all
MU_number =1;
load('C:\Users\dl1920\Desktop\Project\optimization_electrode_version_2\op_inti.mat') % Import parameters of one MU, to run it, please import op_inti.m to workspace direct

% Give an initial electrode position point
p_inti = [-1.8,-0.5,Lmuscle/2];
% p_inti = [1,1,Lmuscle/2];
g_ratio = [1e-8,1e-8,1e-8]; % Give the step size in gradient calculate

% Input learning ratio
alpha_value = input('Please input learning ratio (alpha)=');

p_p = p_inti;

% Choose mode and intial parameters
fprintf('--------Optimization Mode Choose--------\n');
fprintf('1--- gradient descent\n2 --- adam\n3 --- quasi-newton method (DFP approach Hessian)\n4 --- quasi-newton method (BFGS approach Hessian)\n');
opt_mode = input('Please input optimization method: ');

if opt_mode == 1 % Gradient descent
    tic
    alpha = alpha_value;
    
    loop_nm=1;

    run gradient_descent
    time_opti=toc;
    
elseif opt_mode == 2 % Adam
    tic
    alpha = alpha_value;
    gama_v=0.99;
    gama_s=0.999;
    epsilon=1e-8;
    
    vo=[0,0,0];
    s=[0,0,0];
    run adam_opti
    time_opti=toc;
    
elseif opt_mode == 3  % Quasi-Newton (DFP approach Hessian)
    tic
    alpha = [alpha_value,alpha_value,alpha_value];
    Q=ones(3,3);
    g_prev=zeros(1,3);
    p_prev=zeros(1,3);
    
    run quasi_newton
    time_opti=toc;

elseif opt_mode == 4  % Quasi-Newton (BFGS approach Hessian)
    tic
    alpha = [alpha_value,alpha_value,alpha_value];
    Q=ones(3,3);
    g_prev=zeros(1,3);
    p_prev=zeros(1,3);
    
    run quasi_newton_2
    time_opti=toc;
end

run plot_result


    

