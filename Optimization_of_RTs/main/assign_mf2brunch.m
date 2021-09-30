% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Assign MF to specific branch at the end of MN

function [actual_center,cluster_center,nmj_xyz,nmj_z] = assign_mf2brunch(sz,mf_center_to_each_mn,N,Lmuscle,arborization_z_std,branches_z_std)
    % Calculate branches numbers for each MN
	mn_brunch =  1+ round(log(sz./sz(1)));
	
    mf_assign_to_brunch = cell(1,N);
    endplate_area_center = Lmuscle/2;
    nmj_z=cell(1,N);
    nmj_xyz=cell(1,N);
    actual_center=zeros(120,3);
    n_brunch_center=cell(1,N);
    cluster_center=cell(1,N);
    
    for n=1:N
		% K-mean to find MFs in each clusters 
        [mf_assign_to_brunch{n},n_brunch_center{n}] = kmeans(mf_center_to_each_mn{n},mn_brunch(n));
        
		% Calculate z-coordinate for the point of first breaking
		branch_points_z = endplate_area_center + branches_z_std(n) * randn(mn_brunch(n),1);
		
		% Calculate coordinate for NMJ
        for i = 1:size(mf_assign_to_brunch{n},1)
            nmj_z{n}(i) = branch_points_z(mf_assign_to_brunch{n}(i)) + arborization_z_std(n) * randn(); % z-coordinate
            nmj_xyz{n}(i,:) = [mf_center_to_each_mn{n}(i,:),nmj_z{n}(i)]; % x,y  coordiante is same as mf's
            cluster_center{n}(i,:) = [n_brunch_center{n}(mf_assign_to_brunch{n}(i),:), branch_points_z(mf_assign_to_brunch{n}(i))];
        end
		
        actual_center(n,:) =  mean(nmj_xyz{n});
        
    end
   
end