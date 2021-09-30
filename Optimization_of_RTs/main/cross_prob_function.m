% function cross_prob = cross_prob_function(para_inti,sample_size,object_v)
function cross_prob = cross_prob_function(sample_size,object_v)
    cross_prob=zeros(sample_size);
    
    prob_loss = 1./object_v';
    cross_prob_fun = prob_loss;
    
    for i=1:sample_size
        cross_prob(i,:) = cross_prob_fun(i)./sum(cross_prob_fun);
        cross_prob(i,i) = 0;
    end
end