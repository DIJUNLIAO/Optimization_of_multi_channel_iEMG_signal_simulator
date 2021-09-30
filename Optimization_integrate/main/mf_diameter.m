% Geneartion of MF's diameter

function [mf_diameters_to_each_mn,mf_diameters] = mf_diameter(mn_inv_area,N,Nmf,mf_assign_to_mn,mf_N_rec)
    
	% Set basic parameters
	std_d = 9e-6;                
    mean_d = 55e-6;
    cvv = std_d/mean_d;
    
	% Consider MN area
    inv_area = mn_inv_area/sum(mn_inv_area);
    cumul_ia = cumsum(inv_area);
	
    diam_means = zeros(N, 1);
    diam_stds = zeros(N, 1);
    mf_diameters_to_each_mn = cell(1,N);
    mf_diameters = zeros(Nmf,1);
    
    for n=1:N
		% Set means and standard diviations 
		diam_means(n) = mean_d - std_d + cumul_ia(n) * 2*std_d;
		diam_stds(n) = diam_means(n) * cvv/2;
    end
    
    for n=1:N
		% Find MFs in current MU
		fibers_in_mu = find(mf_assign_to_mn == n);
		
		% Generate diameters randomly but respect the size of MU
		mf_diameters(fibers_in_mu) = diam_means(n) + diam_stds(n)*randn(size(fibers_in_mu));
    end
    
    for i=mf_N_rec
       mf_diameters_to_each_mn{mf_assign_to_mn(i)}(end+1,:) = mf_diameters(i,:); 
    end
    
end