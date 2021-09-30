function shiftedd_sfap = sfap_generate(sfap_series,k,sfap,t_steps,mnap_delays,dt,j_delays)
    for nn = 1:t_steps
        sfap(nn,k) = sum(sfap_series(nn,k)); 
    end
    
    sfap_after_shift1 = sfap_shifting(sfap(:,k),mnap_delays(k),dt);
%     shiftedd_sfap = nmj_jittered(sfap_after_shift1,j_delays(k),dt); % when consider neuromusclular junction jitter

    shiftedd_sfap = sfap_after_shift1;
    
end