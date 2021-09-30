% Optimization of electrode position
% Generate MUAP and loss function

function [t_steps,muap,loss_function_value] = optimization_function(p_p,partical_xyz,p_copx_step,nmj_z,v,dt,dz,Lmuscle,sf,mf_center,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,Y,nmj_jitter)
    
    % Choose mode to calculate complex-step result or normal
    if partical_xyz==1
        x=p_p(1)+p_copx_step;
        y=p_p(2);
        z=p_p(3);
    elseif partical_xyz==2
        x=p_p(1);
        y=p_p(2)+p_copx_step;
        z=p_p(3);
    elseif partical_xyz==3
        x=p_p(1);
        y=p_p(2);
        z=p_p(3)+p_copx_step;
    elseif partical_xyz==0
        x=p_p(1);
        y=p_p(2);
        z=p_p(3);
    end

    % initial variables
    ts=2 * max([nmj_z./v ; (30 - nmj_z)./v]);
    t_steps = floor(ts/dt)+1;
    t = 0:dt:ts;
    t=t';
    z_steps = floor(Lmuscle/dz);

    sfap_series = zeros(t_steps,sf);
    sfap=zeros(t_steps,sf);
    sfap_after_shift=zeros(t_steps,sf);
    
    % calculate SFAP in each fiber
    for k = 1:sf
        z_left = nmj_z(k):-dz:0;
        z_right = nmj_z(k):dz:30;
        za = transpose([z_left(end:-1:1), z_right(2:end)]);
        
%         jitter_std = nmj_jitter;
%         j_delays = jitter_std * randn(sf,1);
        
        I = elementary_current_source(nmj_z(k),v(k),t,dz,za,Rmf(k),sigma_i);
        min_radial_dist = mean(2*Rmf(k)) * 1000;
        H = elementary_current_response(mf_center(k,:),za,x,y,z,sigma_z,sigma_r,min_radial_dist);
        sfap_series(:,k) = I'*H;
        sfap_after_shift(:,k) = sfap_generate(sfap_series,k,sfap,t_steps,mnap_delays,dt,j_delays); % Calculate MUAP delay
    
    end

    % Calculate MUAP
    muap = muap_generate(sfap_after_shift,t_steps);

    % Calculate loss function between real MUAP and simulated MUAP
    loss_function_value = loss_function_generate(Y,muap);
end