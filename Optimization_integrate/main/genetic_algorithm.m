% Genetic Algorithm part

% Get visuable MU numbers
% visual_N=size(visuable_N,2);
visual_N=2;

% pre-define arraies
muap=cell(sample_size,visual_N);
muap_inti=cell(1,visual_N);
object_v=zeros(1,sample_size);
mf_center_to_each_mn_each_pa=cell(1,sample_size);
mf_center_to_each_mn_best=cell(1,N);
sz_all=cell(1,sample_size);
loss_function_all_aa=cell(1,sample_size);

% Generation intial parent genetic pool
para_inti_a= parent_generation(rr_range,rm_range,Rmuscle,Lmuscle,sample_size);

% Get MUAPs for a all groups of parameters in parent genetic pool
for i=1:sample_size
	% Gneration loss functions, fitness funcions, MUAPs MN and MF sizes and disturbuations for current parameters
    [loss_function_all_aa{i},~,object_v(i),muapa,mf_center_to_each_mn_each_paa,~,sz_all{i},~,~,~,~] = optimization_recuritment(para_inti_a(:,i),N,Dmf, Lmuscle, mf_centers, mn_centers, Nmf, Rmuscle, visuable_N, Y, dt,dz);
    loss_function_all_a(:,i)=loss_function_all_aa{i};
    for j=1:visual_N
		muap{i,j}=muapa{j};
	end
	for j=1:N
		mf_center_to_each_mn_each_pa{i,j}=mf_center_to_each_mn_each_paa{j};
	end 
end

% Non-dominate Sorting and crowding distance calculating
[level_of_para_a,crowded_indx,level_of_para,crowded_degree,loss_function_all,para_inti,solve_level]=dominated_dominated_order (loss_function_all_aa,visual_N,sample_size,para_inti_a);

% Find and save current best paramenters vectors
[object_min_v,object_min_index]=min(object_v);
object_v_all(1)=object_min_v;
para_all(:,1)=para_inti_a(:,object_min_index);
for j=1:visual_N
    muap_inti{j}=muap{object_min_index,j};
end
for j=1:N
    mf_center_to_each_mn_best{j}=mf_center_to_each_mn_each_pa{i,j};
end
object_v_best = object_min_v;
para_best=para_inti_a(:,object_min_index);
muap_best=muap_inti;
sz_best=sz_all{object_min_index};
loss_function_best=loss_function_all_a(:,object_min_index);
loss_function_quat(:,1)=loss_function_best;
object_fun(1)=object_v(object_min_index);
object_fun_best=object_fun(1);

% iteration part
if object_fun>1
    for g=1:generation_num
		% Clearing caches
        % clearvars -except Dmf Lmuscle mf_centers mn_centers N Nmf object_v_all para_inti para_new para_all Rmuscle visuable_N Y dt dz g muap_inti sample_size mate_number generation_num rr_range rm_range adding_sample visual_N object_v optiz_mode variation_rate object_v_best muap_best sz_best para_best mf_center_to_each_mn_best loss_function_best loss_function_quat
        clearvars -except Dmf Lmuscle mf_centers mn_centers N Nmf object_v_all para_inti para_new para_all Rmuscle visuable_N Y dt dz g muap_inti sample_size mate_number generation_num rr_range rm_range adding_sample visual_N object_v optiz_mode variation_rate object_v_best muap_best sz_best para_best mf_center_to_each_mn_best loss_function_best loss_function_quat level_of_para crowded_degree object_fun object_fun_best loss_function_all
        % Get new genetic pool
		new_number=sample_size*mate_number+adding_sample+sample_size;
        muap=cell(new_number,visual_N);
        muappp=cell(1,visual_N);
        sz_all=cell(1,new_number);
        mf_center_to_each_mn_each_pa=cell(new_number,visual_N);
        mf_center_to_each_mn=cell(1,visual_N);
        loss_function_all_aa=cell(1,new_number);
		
		% Crossover probabilities calculation
        %cross_prob = cross_prob_function(sample_size,object_v); % Traditional method
        cross_prob = cross_prob_function_nsga_2(sample_size,level_of_para,crowded_degree,loss_function_all); % NSGA-II method
		
		clear loss_function_all
        object_v=zeros(1,sample_size*mate_number+adding_sample);
		
		% Crossover, Variation and diversification
        para_new = cross_procedure(new_number,cross_prob,mate_number,sample_size,para_inti,adding_sample,rr_range,rm_range,variation_rate);
        
		clear crowded_degree
        
		% Calculating new fitness function
		for i=1:new_number
            [loss_function_all_aa{i},~,object_v(i),muapa,mf_center_to_each_mn_each_paa,~,sz_all{i},~,~,~,~,~] = optimization_recuritment(para_new(:,i),N,Dmf, Lmuscle, mf_centers, mn_centers, Nmf, Rmuscle, visuable_N, Y, dt,dz); 
            loss_function_all_a(:,i)=loss_function_all_aa{i};
            for j=1:visual_N
                muap{i,j}=muapa{j};
            end
            for j=1:N
                mf_center_to_each_mn_each_pa{i,j}= mf_center_to_each_mn_each_paa{j};
            end
        end
		
		% Non-dominate Sorting and crowding distance calculating
        [level_of_para_a,crowded_indx,level_of_para_aa,crowded_degree_a,loss_function_all,para_intia,solve_level]=dominated_dominated_order (loss_function_all_aa,visual_N,new_number,para_new);
        
		% Natural Selection
		% [para_inti,object_v,new_select] = nature_selection(para_new,object_v,sample_size,mate_number,adding_sample); % Traditional Method
		[para_inti,object_v,new_para_select] = nature_selection_nsga_2(para_intia,object_v,level_of_para_aa,crowded_degree_a,new_number,sample_size,mate_number,adding_sample,loss_function_all); % NSGA-II
        
		% Select minmum in this generation
		[object_min_v,object_min_index]=min(object_v);
        object_v_all(g+1)=object_min_v;
        para_all(:,g+1)=para_intia(:,object_min_index);
        for j=1:N
            mf_center_to_each_mn{j}=mf_center_to_each_mn_each_pa{object_min_index,j};
        end
        for j=1:visual_N
            muappp{j}= muap{object_min_index,j}; 
        end
        crowded_degree=crowded_degree_a(new_para_select);
        level_of_para=level_of_para_aa(new_para_select);
        sz=sz_all{object_min_index};
        loss_function_new=loss_function_all_a(:,object_min_index);
        object_fun(g+1)=object_v(object_min_index);
        
		% Compare to previous best solution
		for j=1:visual_N
            judeg_each_loss(j) = (loss_function_new(j)<=loss_function_best(j));
        end
		
		% Get optimum upto now
        if size(find(judeg_each_loss==1),2)==visual_N
            object_fun_best=object_fun(g+1);                    
            object_v_best = object_min_v;  
            muap_best=muappp; 
            sz_best=sz;   
            para_best=para_all(:,g+1);  
            mf_center_to_each_mn_best=mf_center_to_each_mn; 
            loss_function_best=loss_function_new;
        end
        loss_function_quat(:,g+1)=loss_function_new;
        
		% if the result are small enough, break
		if object_min_v<=1
            break
        end
    end
end

loop_time=g+1;




