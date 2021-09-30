# Readme file of Optimization_of_electrode

This part compared four optimization methods, two first order method (gradient descent, ADAM); two second order method (Quasi-Newton, DFP and BFGS). It used the above method to optimize and find a electrode position that best match experiential data.

The following introduction of each file is according to the sequences when the program is executing.

## MAIN FILE

### optimization_recuritment_para.m

This file is used to choose adding initial workspace, choose optimization method and get the basic parameters of optimization. 

***NOTE:*** Please comment load command in line 6 and adding ***op_inti.mat*** to workspace when execute this program.

### gradient_descent.m

This is the main body of gradient descent method.

**optimization_function.m:** Main procedure to generate MUAP and its loss function.

​	**elementary_current_source.m:** Generate elementary current source (***I***).

​	**elementary_current_response.m:** Generate elementary current response (***H***).

​	**sfap_generate.m:** Generate SFAP for each MF and consider MNAP propagation delay.

​		**sfap_shifting.m:** Calculate MNAP delay by shifting SFAP time sequences.

​		**nmj_jittered.m:** Generate NMJ jitter if it required.

​	**muap_generate.m:** Calculate MUAP.

​	**loss_function_generate.m:** Calculate loss function for each MUAP

### adam_opti.m

This is the main body of ADAM method.

The MUAP generating part is same as above, so it no longer shows the descriptions of each file.

### quasi_newton.m

This is the main body of DFP Quasi-Newton method.

The MUAP generating part is same as above, so it no longer shows the descriptions of each file.

### quasi_newton_2.m

This is the main body of BFGS Quasi-Newton method.

The MUAP generating part is same as above, so it no longer shows the descriptions of each file.

## PLOT FILE

**plot_result.m: ** Plot the MUAPs (real MUAP, simulating MUAP before and after optimizing). Plot the change of loss function and the change of electrode position in each iteration.

## OTHER FILE

**absoulet_error_H.m: ** Calculate and plot absolute error for different gradient calculating methodology. This is used to compare the performance of different method.

