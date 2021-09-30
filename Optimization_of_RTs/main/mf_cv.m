% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Generate conductive velocities of MFs according to their diameters

function mf_cvs_to_each_mn = mf_cv(mf_diameters,N,mf_N_rec,mf_assign_to_mn)
    mf_cvs_to_each_mn=cell(1,N);

    max_diameter = 85e-6;
    min_diameter = 22e-6;
    intercept = 2200;
    max_cv = 5200;
    
    diameters = mf_diameters;
    
    diameters(diameters < min_diameter) = min_diameter;
    diameters(diameters > max_diameter) = max_diameter;
    
    slope = (max_cv-intercept)/(max_diameter-min_diameter);
    mf_cv = intercept + (diameters-min_diameter) * slope;
    
    for i=mf_N_rec
       mf_cvs_to_each_mn{mf_assign_to_mn(i)}(end+1,:) = mf_cv(i,:); 
    end
end