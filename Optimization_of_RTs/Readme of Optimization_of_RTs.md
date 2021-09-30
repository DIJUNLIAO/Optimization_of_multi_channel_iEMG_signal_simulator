# Readme file of Optimization_of_RTs

This part uses genetic algorithm (NSGA-II) method to find suitable RT parameters in order to get MN territories and MF innervations. 

The following introduction of each file is according to the sequences when the program is executing. MUAP generation part of this program is similar to **Optimization_electrode**.

## MAIN FILE：

### optimization_recuritment_para.m

This file is used to choose adding initial workspace, choose optimization method and get the basic parameters of optimization. 

***NOTE:*** Please comment load command in line 6 and adding ***opti_rr_inti.mat*** to workspace when execute this program.



### genetic_algorithm.m

This is the main body of genetic algorithm.

**parent_generation.m:**  This file is used to generate parent genetic pool.



**optimization_recuritment.m:** It used to generate the basic physiological structure of muscles and all MUAPs in detectable area. (This part costs most of time).

​	**recruitment_thresholds_and_size.m:** Generating RTs and MU sizes.

​	**innveration_area.m:**  Generating innervation areas of each MU.



​	**assign_mf2mn.m:**  Assignment each MF to specific MN.

​	**mf_diameter.m:** Generate diameters of each MF according to the size of MU that they belong to.

​	**mf_cv.m:** Generate conductive velocities of each MF according to their diameters.



​	**nmj_std.m:** Generate standard deviation that used to generate the coordinate of NMJ.

​	**assign_mf2brunch.m:** Assign MF to specific branch at the end of MN.

​	**nerve_path.m:** Generate nerve path from MN center to branches point and branches point to arborization point. This is  	Used to simulate the axons so that it can calculate the MNAP delay separately. 

​	**mnap_delay_calc.m:** MNAP propagation delay calculating.

​	

​	**muap_generation_all.m:** Calculate of MUAP

​		**elementary_current_source.m:** Calculate element current sources (***I***).

​		**elementary_current_response.m:** Calculate element current response (***H***).

​		**sfap_generate.m:** Calculate SFAP and consider MNAP propagation delay.

​			**sfap_shifting.m:** Consider MNAP propagation delay by shifting SFAP time sequences.

​		**muap_generate.m:** Generate a MUAP



​	**loss_function_generate.m:** Generate loss functions and fitness function.



**dominated_dominated_order.m:** Non-dominate sorting, crowding distance calculating and sorting

​	**crowded_calculate.m:** Calculating crowding distances

**cross_prob_function_nsga_2.m:** Calculating crossover probabilities (According to fitness function and non- dominated level). For NSGA-II special

**cross_prob_function.m:** Calculating crossover probabilities according to fitness function only. For traditional method.

**cross_procedure.m:** Crossover procedure, variation and diversification genetic pool.

**nature_selection_nsga_2.m:** Natural Selection, choose survival offspring for parent genetic pool in next iteration. For NSGA-II Special. (According to fitness function, non-dominated level (Highest priority) and crowding distance).

## PLOT FILE：

**plot_mf_assignment.m:** Plot MFs and MNs distributions (shown all MUs). 

**plot_mf_assignment_visiable.m:** Plot MFs and MNs distributions (shown detectable MUs only). 

**plot_muap.m:**  Plot MUAPs (Real MUAP, simulated MUAP after optimization).

**plot_domained_level.m:** Plot solutions and show their non-dominated levels .

