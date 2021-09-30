% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Non-dominate sorting, crowding distance calculating and sorting

function [level_of_para_a,crowded_indx,level_of_para,crowded_indx_all,loss_function_all_i,para_inti_i,solve_level]=dominated_dominated_order (loss_function_all,visual_N,sample_size,para_inti)
    for i=1:visual_N
       for j=1:sample_size
          loss_function(i,j)=loss_function_all{j}(i);  
       end
    end

    g=0;
    inde_vv=1:sample_size;
    while size(find(~inde_vv),2)~=sample_size
        g=g+1;
        h=0;
        clear dominat_indx
		% Find non-dominated solution, compare a solution to all other solution
        for k=1:sample_size
           for i=1:visual_N
                better_set(i,:)=(loss_function(i,k)>=loss_function(i,:)); % Compare objectives one-by-one
           end

            for j=1:sample_size
                if (j==k) || (inde_vv(j)== 0) % Excluded compare with itself
                    dominat_indx(j)=0;
                else
                    if size(find(~better_set(:,j)),1)==0 % If all objective are better, then it is non-dominated
                        dominat_indx(j)=1;
                    else
                        dominat_indx(j)=0;
                    end
                end
            end
            dominating_set{k}=find(dominat_indx==1); % Set included all solutions in current non-dominated level
            if size(dominating_set{k},2)==0 % if it is not in this non-dominated level, move to next level to compare
                h=h+1;
                solving_level(h)=k;
            end
        end 
        for i=solving_level
            inde_vv(i)=0;
        end

		% Sorting and save solutions and sets
        if g==1
            solve_level_a=solving_level;
            [~,indx]=sort(loss_function(1,solve_level_a));
            for q=1:size(solve_level_a,2)
               solve_level{g}(q)=solve_level_a(indx(q));
               level_of_para_a(solve_level_a(indx(q)))=g;
               loss_func{g}(:,q)=loss_function(:,solve_level_a(indx(q)));
            end
            dominating_set_all=dominating_set;
        else
            solve_level_a=setdiff(solving_level, solving_level_last);
            [~,indx]=sort(loss_function(1,solve_level_a));
            for q=1:size(solve_level_a,2)
               solve_level{g}(q)=solve_level_a(indx(q));
               level_of_para_a(solve_level_a(indx(q)))=g;
               loss_func{g}(:,q)=loss_function(:,solve_level_a(indx(q)));
            end
        end
        solving_level_last=solving_level;
    end

    reconstruct_index=[];
    for i=1:size(solve_level,2)
        reconstruct_index=horzcat(reconstruct_index,solve_level{i});
    end
	
	% Calculating crowding distance
    crowded_indx = crowded_calculate (solve_level,loss_func);

	% Sorting each set by crowding distance
    for i=1:size(solve_level,2)
        [crowded_indx_order{i},indx_c]=sort(crowded_indx{i});
        for q=1:size(solve_level{i},2)
            solve_level_f{i}(q)=solve_level{i}(indx_c(q));
            loss_func_f{i}(:,q)=loss_func{i}(:,indx_c(q));
        end
    end

    loss_function_all_i=[];
    reconstruct_index_f=[];
    crowded_indx_all=[];
    for i=1:size(solve_level,2)
        loss_function_all_i=horzcat(loss_function_all_i,loss_func_f{i});
        reconstruct_index_f=horzcat(reconstruct_index_f,solve_level_f{i});
        crowded_indx_all=horzcat(crowded_indx_all,crowded_indx_order{i});
    end

    a=0;
    for i=reconstruct_index_f
        a=a+1;
        level_of_para(a)=level_of_para_a(i);
        para_inti_i(:,i)=para_inti(:,i);
    end
    
    
end