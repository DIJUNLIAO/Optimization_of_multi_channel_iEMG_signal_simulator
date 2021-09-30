% function [t_steps,muap,loss_function_value] = muap_generation_all(p_p,nmj_z,v,dt,dz,Lmuscle,sf,mf_center,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,Y,nmj_jitter)
function muap_part = muap_generation_all(z,nmj_z,v,dt,dz,Lmuscle,sf,para,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,nmj_jitter)    
    % initial variables
    ts=real(2 * max([nmj_z./v ; (30 - nmj_z)./v]));
    t_steps = floor(ts/dt)+1;
    t = 0:dt:ts;
    t=t';
    z_steps = floor(Lmuscle/dz);

    sfap_series = zeros(t_steps,sf);
    sfap=zeros(t_steps,sf);
    sfap_after_shift=zeros(t_steps,sf);
    ra=para(3);
	
    % calculate SFAP in each fiber
    for k = 1:sf
        z_left = nmj_z(k):-dz:0;
        z_right = nmj_z(k):dz:30;
        za = transpose([z_left(end:-1:1), z_right(2:end)]);
        
        jitter_std = nmj_jitter;
        j_delays = jitter_std * randn(sf,1);
        
        I = elementary_current_source(nmj_z(k),v(k),t,dz,za,Rmf(k),sigma_i);
        H = elementary_current_response(za,ra,z,sigma_z,sigma_r);
        sfap_series(:,k) = I'*H;
        sfap_after_shift(:,k) = sfap_generate(sfap_series,k,sfap,t_steps,mnap_delays,dt,j_delays); % Calculate MUAP delay
    
    end

    % Calculate MUAP
    muap_part = muap_generate(sfap_after_shift,t_steps);
end