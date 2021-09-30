% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Loss function and fitness function

function [loss_function,obj_function,muap] = loss_function_generate(Y,muap,visual_N)
    loss_function = zeros(visual_N,1);
    
	% Generate loss function
    for n=1:visual_N
        step_all = abs(size(muap{n},1)-size(Y{n},1));
       if size(Y{n},1)<size(muap{n},1)
           if mod(step_all,2) == 0
               Y{n}=[zeros(step_all/2,1);Y{n};zeros(step_all/2,1)];
           else
               Y{n}=[zeros(floor(step_all/2),1);Y{n};zeros(floor(step_all/2)+1,1)];
           end
       elseif size(Y{n},1)>size(muap{n},1)
           if mod(step_all,2) == 0
               muap{n}=[zeros(step_all/2,1);muap{n};zeros(step_all/2,1)];
           else
               muap{n}=[zeros(floor(step_all/2),1);muap{n};zeros(floor(step_all/2)+1,1)];
           end
       end
       loss_function_series = (Y{n}(:,1)-muap{n}).^2;
       loss_function(n) = sum(loss_function_series); 
    end

% Fitness function    
%    obj_function = sum(loss_function);
%    obj_function = loss_function(1)*0.2+loss_function(2)*0.8;
   obj_function = loss_function(1)*0.5+loss_function(2)*0.5;
    
end