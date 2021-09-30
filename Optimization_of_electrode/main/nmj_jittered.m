function jittered_sfap = nmj_jittered(sfap_after_shift1,jt_delays,dt)
    sfap_j_shift = sfap_after_shift1;
    
    if ~mod(numel(sfap_j_shift),2)
        sfap_j_shift = [sfap_j_shift; 0];
        padded = 1;
    else
        padded = 0;
    end

    N = length(sfap_j_shift);

    SFAP_j_shift = fft(sfap_j_shift);
    SFAP_j_shift_0 = SFAP_j_shift(1);
    SFAP_j_shift_k = SFAP_j_shift(2:ceil(end/2));

    Sk = SFAP_j_shift_k .* exp(1i * (2*pi*jt_delays/dt) * (1:length(SFAP_j_shift_k))'/N);
    S = [SFAP_j_shift_0; Sk; conj(SFAP_j_shift_k(end:-1:1))];
    SFAP_j_shifted = ifft(S);

    if padded
        SFAP_j_shifted = SFAP_j_shifted(1:end-1);
    end


    jittered_sfap = SFAP_j_shifted;
end