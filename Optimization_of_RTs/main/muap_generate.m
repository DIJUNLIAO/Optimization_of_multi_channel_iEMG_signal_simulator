function muap = muap_generate(sfap_after_shift,t_steps)
    muap=zeros(t_steps,1);
    for tt=1:t_steps
        muap(tt) = sum(sfap_after_shift(tt,:)); 
    end
end