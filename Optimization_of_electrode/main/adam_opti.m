% Optimization of electrode position
% Adam

loop_nm=1;

while (((p_p(1)^2+p_p(2)^2 <= Rmuscle^2) && (p_p(3) > 0) && (p_p(3) < 30))) % Loop until the electrode poistion are out of muscle's boundary
% while (1)
    clearvars -except g p_prev p_current p_p alpha g_ratio loop_nm p_best p_p dt dz Lmuscle mf_center mnap_delays nmj_z Rmf Rmuscle sf sigma_i sigma_r sigma_z v Y gama_v gama_s epsilon vo s object_value_all opt_mode muap_first alpha_value nmj_jitter MU_number
    
    % Use complex step method to approach gradient
    p_copx_step_x = sqrt(-1)*g_ratio(1);    % Get complex step of each component of position
    p_copx_step_y = sqrt(-1)*g_ratio(2);
    p_copx_step_z = sqrt(-1)*g_ratio(3);
    p_copx_step = [p_copx_step_x,p_copx_step_y,p_copx_step_z];
    
    % Calculate current optimization result
    [t_steps,muap,objective_value] = optimization_function(p_p,0,0,nmj_z,v,dt,dz,Lmuscle,sf,mf_center,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,Y,nmj_jitter);
    [t_steps_coxx,muap_coxx,objective_value_coxx] = optimization_function(p_p,1,p_copx_step_x,nmj_z,v,dt,dz,Lmuscle,sf,mf_center,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,Y,nmj_jitter);
    [t_steps_coxy,muap_coxy,objective_value_coxy] = optimization_function(p_p,2,p_copx_step_y,nmj_z,v,dt,dz,Lmuscle,sf,mf_center,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,Y,nmj_jitter);
    [t_steps_coxz,muap_coxz,objective_value_coxz] = optimization_function(p_p,3,p_copx_step_z,nmj_z,v,dt,dz,Lmuscle,sf,mf_center,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,Y,nmj_jitter);
    
    if loop_nm==1
        muap_first=muap; % Adding MUAP at initial electrode position
    end
    
    object_value_all(loop_nm) = objective_value;   % Save loss function value
    
    g = [imag(objective_value_coxx),imag(objective_value_coxy),imag(objective_value_coxz)]./(g_ratio); % Get gradient
    
    p_prev = p_p;  % iteration step
    p_current(:,loop_nm)=p_p;
    vo = gama_v .* vo + (1-gama_v).*g;
	s = gama_s .* s + (1-gama_s).*(g.*g);
	v_corrected = vo./(1-gama_v.^(loop_nm+1));
	s_corrected = s./(1-gama_s.^(loop_nm+1));
    p_p=p_p-(alpha.*v_corrected./(epsilon+sqrt(s_corrected)));

    % Ending conditions
    if (g(1)==0 && g(2)==0 && g(3)==0) % if all elements of gradient are equal to 0 (get the minimum)
        p_best=p_p;
        loop_nm=loop_nm+1;
        break
    end
    if (loop_nm>=2) && (abs(objective_value-object_value_all(end-1)) <=10e-12) % if the step sizes are too small
       p_best = p_p; 
       loop_nm=loop_nm+1;
       break
    end
    if objective_value <=10e-3 % if loss function is small enough
       p_best = p_p; 
       loop_nm=loop_nm+1;
       break
    end

    loop_nm=loop_nm+1;
    p_best=p_prev;
end
return


