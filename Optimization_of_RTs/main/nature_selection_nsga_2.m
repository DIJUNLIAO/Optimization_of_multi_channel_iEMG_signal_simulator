% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Natural Selection, choose survival offspring for parent genetic pool in next iteration

function [para_offspring,object_nv,new_para_select] = nature_selection_nsga_2(para_new,object_v,level_of_para,crowded_degree,new_number,sample_size,mate_number,adding_sample,loss_function_all)
    for i = 1:new_number
		objective_fun(i)=sum(loss_function_all(:,i));
	end
	
	zero_object_v = find(~object_v);
    
	% probabilities of non-domaining levels
	prob_level = 1./level_of_para;
    
	for i=1:new_number
		fitness_prob(i)=objective_fun(i)^(-1)/sum(objective_fun^(-1)); % probabilities of fintness function
		prob_loss = (0.7*prob_level(i))*(0.1*crowded_degree(i))*(0.2*fitness_prob(i)); % full probabilities
        if prob_loss(i)==Inf
            if level_of_para(i) == 1 && (size(find(level_of_para==1),2)==1 || size(find(level_of_para==1),2)==2)
                prob_loss(i)=50;
            end
        end
    end
    
	prob_loss = prob_loss./sum(prob_loss);
    
	% if there are one parameters pair that can get exact same MUAP as real MUAP
	if size(zero_object_v,2)~=0
       for i=zero_object_v
           prob_loss(i)=1;
       end 
    end
    
	% Selecte survival offsprings
    new_para_select = randsample(new_number,sample_size,true,prob_loss');
    para_offspring=zeros(2,sample_size);
    object_nv=zeros(1,sample_size);
    
    k=0;
    for i=new_para_select'
        k=k+1;
        para_offspring(:,k)= para_new(:,i);
        object_nv(k)= object_v(i);
    end
end