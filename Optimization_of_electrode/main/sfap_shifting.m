function sfap_after_shift1 = sfap_shifting(sfap1,mdelays,dt)
    shifting_step_sfap = floor(mdelays/dt);
    sfap_after_shift1 = circshift(sfap1, shifting_step_sfap, 1);
    sfap_after_shift1(1:shifting_step_sfap) = 0;
    sfap_after_shift1(end+shifting_step_sfap+1:end) = 0;
end