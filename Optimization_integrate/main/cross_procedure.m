% Crossover Procedure, Variation and diversification

function para_new = cross_procedure(new_number,cross_prob,mate_number,sample_size,para_inti,adding_sample,rr_range,rm_range,variation_rate)
    
	mate_select=cell(1,sample_size);
    gene_choose=cell(1,sample_size);
    varaiation_num=round(variation_rate*sample_size*mate_number);
    para_new = zeros(2,new_number);
	
	% Varaiation individual finding
	varaiation_para_rr=randi(sample_size*mate_number,1,varaiation_num);
	varaiation_para_rm=randi(sample_size*mate_number,1,varaiation_num);
    varaiation_para_x=randi(sample_size*mate_number,1,varaiation_num);
    varaiation_para_y=randi(sample_size*mate_number,1,varaiation_num);
	varaiation_para_z=randi(sample_size*mate_number,1,varaiation_num);
	
	% Crossover
    k=0;
    for i=1:sample_size
        mate_select{i} = randsample(sample_size,mate_number,true,cross_prob(:,i)'); % Choose crossover mate according to crossover probabilities
        for n=1:mate_number
           k=k+1;
           gene_choose = randi([1 4],1,mate_number); % Choose exchange site
           para_new(:,k)=[para_inti(1:gene_choose,mate_select{i}(n));para_inti(gene_choose+1:end,i)]'; % Exchange
        end
    end
	
	% Variation
    para_vara_x=parent_generation(rr_range,rm_range,varaiation_num); 
    para_vara_y=parent_generation(rr_range,rm_range,varaiation_num);
    para_vara_z=parent_generation(rr_range,rm_range,varaiation_num); 
    para_vara_rr=parent_generation(rr_range,rm_range,varaiation_num);
	para_vara_rm=parent_generation(rr_range,rm_range,varaiation_num); 
	
	n=0;
    for i=varaiation_para_rr
        n=n+1;
        para_new(1,i)= para_vara_rr(1,n);
    end
    n=0;
    for i=varaiation_para_rm
        n=n+1;
        para_new(2,i)= para_vara_rm(2,n);
    end
	for i=varaiation_para_x
        n=n+1;
        para_new(3,i)= para_vara_x(3,n);
    end
    n=0;
    for i=varaiation_para_y
        n=n+1;
        para_new(4,i)= para_vara_y(4,n);
    end
	for i=varaiation_para_z
        n=n+1;
        para_new(5,i)= para_vara_z(5,n);
    end
	
	% Diversification
    para_new(:,sample_size*mate_number+1:sample_size*mate_number+adding_sample)= parent_generation(rr_range,rm_range,adding_sample);
    para_new(:,sample_size*mate_number+adding_sample+1:new_number)= para_inti;
end