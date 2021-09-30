function [muap,mf_diameters,mf_center_to_each_mn,nmj_zz,sz,mf_N_rec,mf_assign_to_mn,actual_center,cluster_center,nmj_xyz] = optimization_recuritment(para,N,Dmf, Lmuscle, mf_centers, mn_centers, Nmf, Rmuscle, visuable_N, Y, dt,dz)
    % Get parameters for simulating physiological structures and MUAPs
	rr=para(1);
    rm=para(2);
    z=para(4);
    
	% RTs, MU sizes and MU innervation area 
    muapp = cell(1,size(visuable_N,2));
    sz = recruitment_thresholds_and_size(rr, rm, N);
    [mn_inv_number,mn_inv_area] = innveration_area(sz,Rmuscle,Dmf);
    mf_number = round((Rmuscle^2) * pi * Dmf);
    
	% Assignment MF to MN, generate diameter and conductive velocity of each MF
    [mf_N_rec,mf_assign_to_mn,mf_center_to_each_mn]= assign_mf2mn(mf_number,mn_inv_area,mn_inv_number,N,mf_centers,mn_centers, Rmuscle);
    [mf_diameters_to_each_mn,mf_diameters] = mf_diameter(mn_inv_area,N,Nmf,mf_assign_to_mn,mf_N_rec);
    mf_cvs_to_each_mn = mf_cv(mf_diameters,N,mf_N_rec,mf_assign_to_mn);
    
	% Assignment each MF to specific branches in MN, generate the coordinates of each NMJ and calculate MNAP delay for each MUAP
    [arborization_z_std,branches_z_std]=nmj_std(sz);
    [actual_center,cluster_center,nmj_xyz,nmj_zz] = assign_mf2brunch(sz,mf_center_to_each_mn,N,Lmuscle,arborization_z_std,branches_z_std);
    nerve_paths = nerve_path(actual_center,cluster_center,nmj_xyz,nmj_zz,N);
    mnap_delayss = mnap_delay_calc(nerve_paths,N);
    
    n=0;
    
    for ii=1:N
	
		% initial parameters
        mnap_delays = mnap_delayss{ii};
        mf_center = mf_center_to_each_mn{ii};
        nmj_z = nmj_zz{ii}';
        Rmf = mf_diameters_to_each_mn{ii}./2;
        v = mf_cvs_to_each_mn{ii};
        sf = size(mnap_delayss{ii},1);
        sigma_i = 1.01e3;
        sigma_r = 0.063e3;
        sigma_z = 0.33e3;
        nmj_jitter = 3.5e-5;
		
		% Calculate MUAPs
        muap{ii} = muap_generation_all(z,nmj_z,v,dt,dz,Lmuscle,sf,mf_center,sigma_z,sigma_r,Rmf,sigma_i,mnap_delays,nmj_jitter);     
    end
    
end


