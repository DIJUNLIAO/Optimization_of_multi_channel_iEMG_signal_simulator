function cross_prob = cross_prob_function_nsga_2(sample_size,level_of_para,crowded_degree,loss_function_all)
    for i = 1:sample_size
		objective_fun(i)=sum(loss_function_all(:,i));
	end
	
	cross_prob=zeros(sample_size);
    
	% probabilities of non-domaining levels
    prob_level = 1./level_of_para;
    
    for i=1:sample_size
		% probabilities of fintness function
		fitness_prob(i)=objective_fun(i)^(-1)/sum(objective_fun^(-1));
		cross_prob_fun = prob_level(i)*fitness_prob(i); % Crossover probabilities
		if level_of_para(i) >= 5
				cross_prob_fun(i)=0.0001; % if the non-domaining level is too high
			end
        if ccrowded_degree(i)==Inf
            if crowded_degree(i) == 1 && (size(find(level_of_para==1),2)==1 || size(find(level_of_para==1),2)==2)
                cross_prob_fun(i)=50; % if all points in a level are boundary points
            else
                cross_prob_fun(i)=0.001; % if it is boundary point
            end
        end
    end
    for i=1:sample_size
        cross_prob(i,:) = cross_prob_fun(i)./sum(cross_prob_fun);
        cross_prob(i,i) = 0;
    end
end