% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Crossover Procedure, Variation and diversification

function para_new = cross_procedure(new_number,cross_prob,mate_number,sample_size,para_inti,adding_sample,rr_range,rm_range,variation_rate)
    
	mate_select=cell(1,sample_size);
    gene_choose=cell(1,sample_size);
    varaiation_num=round(variation_rate*sample_size*mate_number);
    para_new = zeros(2,new_number);
	
	% Varaiation individual finding
%     varaiation_para=randi(sample_size*mate_number,1,varaiation_num);
    varaiation_para_x=randi(sample_size*mate_number,1,varaiation_num);
    varaiation_para_y=randi(sample_size*mate_number,1,varaiation_num);
	
	% Crossover
    k=0;
    for i=1:sample_size
        mate_select{i} = randsample(sample_size,mate_number,true,cross_prob(:,i)'); % Choose crossover mate according to crossover probabilities
        gene_choose{i} = randi([1 2],1,mate_number); % Choose exchange part
        for n=1:mate_number % Exchange
           k=k+1;
           if gene_choose{i}(n) == 1
               para_new(:,k)=[para_inti(1,mate_select{i}(n));para_inti(2,i)]';
           else
               para_new(:,k)=[para_inti(1,i);para_inti(2,mate_select{i}(n))]';
           end
        end
    end
	
	% Variation
    para_vara_x=parent_generation(rr_range,rm_range,varaiation_num); 
    para_vara_y=parent_generation(rr_range,rm_range,varaiation_num);
    
	n=0;
    for i=varaiation_para_x
        n=n+1;
        para_new(1,i)= para_vara_x(1,n);
    end
    n=0;
    for i=varaiation_para_y
        n=n+1;
        para_new(2,i)= para_vara_y(2,n);
    end
	
	% Diversification
    para_new(:,sample_size*mate_number+1:sample_size*mate_number+adding_sample)= parent_generation(rr_range,rm_range,adding_sample);
    para_new(:,sample_size*mate_number+adding_sample+1:new_number)= para_inti;
end