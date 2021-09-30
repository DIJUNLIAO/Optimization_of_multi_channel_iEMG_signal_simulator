% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Genarate standard diviation that used to generate NMJ's coordinate

function [arborization_z_std,branches_z_std]=nmj_std(sz)
    arborization_z_std = zeros(1,120);
    branches_z_std = zeros(1,120);
    for i=1:120
        arborization_z_std(i) = 0.5 + sum(sz(1:i))/sum(sz) * 1.5;
        branches_z_std(i) = 1.5 +  sum(sz(1:i))/sum(sz) * 4;
    end
end