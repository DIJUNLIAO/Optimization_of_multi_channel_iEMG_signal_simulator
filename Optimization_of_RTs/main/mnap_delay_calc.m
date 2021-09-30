% Optimization of MN terratories and MF innervation via Recruiment Thershould
% MNAP propagation delay calculating

function mnap_delays = mnap_delay_calc(nerve_paths,N)
    nmj_cv=[5000,2000];
    mnap_delays = cell(1,N);
    for n =1:N
       mnap_delay = nerve_paths{n}./repmat(nmj_cv(:)', size(nerve_paths{n},1), 1);
       mnap_delays{n} = sum(mnap_delay,2); 
    end
end