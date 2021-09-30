clear all
load('C:\Users\dl1920\Desktop\Project\MUAP_optimization_recuritment-main\opti_rr_inti.mat') % import basic parameters, to excute this program, just import opti_rr_inti.m into workspace 

% Basic parameters
vis_N=11;
rr_range=[10,100];
rm_range=[0.1,1];
parameter_sample_size = 20;
assignment_change = 300;
z=15;

n=zeros(1,vis_N);
n_element_all=zeros(1,parameter_sample_size);
muap_select=cell(vis_N,parameter_sample_size);
para_opt=cell(vis_N,parameter_sample_size);

while(1)
	% Random choose a groups of parameters
    radat=Rmuscle.*rand(1,parameter_sample_size);
	rr = (rr_range(2)-rr_range(1)).*rand(1,parameter_sample_size) + rr_range(1);
    rm = (rm_range(2)-rm_range(1)).*rand(1,parameter_sample_size) + rm_range(1);
	
	for i=1:parameter_sample_size
		parr(1,:)=rr;
		parr(2,:)=rm;
	end
	
    for o=1:parameter_sample_size % 20 radius
        rada=radat(o); % Choose a radius
		for i1=1:parameter_sample_size % 20 parameters-pairs each radius
			para=[parr(1,i1),parr(2,i1),rada,z];
			for i2=1:assignment_change % Change 300 different assignment for each parameters
				[muap,mf_diameters,mf_center_to_each_mn,nmj_zz,sz,mf_N_rec,mf_assign_to_mn,actual_center,cluster_center,nmj_xyz] = optimization_recuritment(para,N,Dmf, Lmuscle, mf_centers, mn_centers, Nmf, Rmuscle, visuable_N, Y, dt,dz);
				for i=1:vis_N
					for j=1:N
						% Calculate loss function
						loss_sum=0;
						if size(muap{j},1)>size(Y{i},1)
							for k=1:size(Y{i},1)
								loss_sum=loss_sum+(muap{j}(k)-Y{i}(k))^2;
							end
						else
							for k=1:size(muap{j},1)
								loss_sum=loss_sum+(muap{j}(k)-Y{i}(k))^2;
							end
						end
						
						% Select satified MUAPs
						if n(i)<parameter_sample_size
							if loss_sum<=5
								n(i)=n(i)+1;
								muap_select{i,n(i)}=muap{j};
								para_opt{i,n(i)}=para;
								assign_group = i2;
							end
						else
							continue
						end
					end
				end
			end
		end
    end
	
	% if all MUs simular to real MUs has been found 
    for q=1:vis_N
       if n(q)==parameter_sample_size
           n_element_all(q)=1;
       end
    end
    if size(find(~n_element_all),2)==0
       break 
    end
end