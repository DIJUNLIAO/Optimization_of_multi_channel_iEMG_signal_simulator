function [para_offspring,object_nv,new_para_select] = nature_selection(para_new,object_v,sample_size,mate_number,adding_sample)
    zero_object_v = find(~object_v);
    prob_loss = 1./object_v;
    prob_loss = prob_loss./sum(prob_loss);
    if size(zero_object_v,2)~=0
       for i=zero_object_v
           prob_loss(i)=1;
       end 
    end
    
    new_para_select = randsample(sample_size*mate_number+adding_sample,sample_size,true,prob_loss');
    para_offspring=zeros(2,sample_size);
    object_nv=zeros(1,sample_size);
    
    k=0;
    for i=new_para_select'
        k=k+1;
        para_offspring(:,k)= para_new(:,i);
        object_nv(k)= object_v(i);
    end
end