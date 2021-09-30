function crowded_indx = crowded_calculate (solve_level,loss_func)
    for i=1:size(solve_level,2)
        crowded_indx{i}=zeros(1,size(solve_level{i},2));
        crowded_indx{i}(1)=Inf;
        crowded_indx{i}(end)=Inf;
        for j=2:size(solve_level{i},2)-1
            crowded_indx{i}(j)=sum(abs(loss_func{i}(j+1)-loss_func{i}(j-1))./(max(loss_func{i})-min(loss_func{i})));
        end
    end
end