# Readme file of Optimization_simplification

This part inspired by FPS method, it uses enumeration method to find many suitable RT parameters in order to get MN territories and MF innervations. 

The following introduction of each file is according to the sequences when the program is executing. This part, most functions (in muscle's physiological structure simulation and MUAP generation) are same as them in **Optimization_of_RTs**.

## MAIN FILE：

### muap_find.m

This is the main body of this project. It included the loss function calculation and MUAP comparation.

***NOTE:*** Please comment load command in line 2 and adding ***opti_rr_inti.mat*** to workspace when execute this program.



**optimization_recuritment.m:** It used to generate the basic physiological structure of muscles and all MUAPs in detectable area. (This part costs most of time).

​	**recruitment_thresholds_and_size.m:** Generating RTs and MU sizes.

​	**innveration_area.m:**  Generating innervation areas of each MU.



​	**assign_mf2mn.m:**  Assignment each MF to specific MN.

​	**mf_diameter.m:** Generate diameters of each MF according to the size of MU that they belong to.

​	**mf_cv.m:** Generate conductive velocities of each MF according to their diameters.



​	**nmj_std.m:** Generate standard deviation that used to generate the coordinate of NMJ.

​	**assign_mf2brunch.m:** Assign MF to specific branch at the end of MN.

​	**nerve_path.m:** Generate nerve path from MN center to branches point and 			    	branches point to arborization point. This is  used to simulate the axons so that it 	can calculate the MNAP delay separately. 

​	**mnap_delay_calc.m:** MNAP propagation delay calculating.

​	

​	**muap_generation_all.m:** Calculate of MUAP

​		**elementary_current_source.m:** Calculate element current sources (***I***).

​		**elementary_current_response.m:** Calculate element current response (***H***). Here it use radius to calculate rather than 		the electrode position. 

​		**sfap_generate.m:** Calculate SFAP and consider MNAP propagation delay.

​			**sfap_shifting.m:** Consider MNAP propagation delay by shifting SFAP time sequences.

​		**muap_generate.m:** Generate a MUAP

## PLOT FILE：

**plot_muap.m:**  Plot MUAPs (Real MUAP, selected simulated MUAP after optimization).

