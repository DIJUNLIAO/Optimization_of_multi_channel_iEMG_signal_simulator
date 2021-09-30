% RTs and MU sizes generating part

function size = recruitment_thresholds_and_size(rr, rm, N)
    
    rt = zeros(1,N);
    size = zeros(1,N);
    
    for n = 1:N
        rt(n) = (rm/rr)*exp(n*log(rr)/N);
        size(n) = rt(n)/rm;
    end
    
end