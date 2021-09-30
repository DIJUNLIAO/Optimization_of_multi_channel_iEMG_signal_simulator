% Function to randomly generate parent genetic pool

function para_inti= parent_generation(rr_range,rm_range,Rmuscle,Lmuscle,sample_size)
    rng('default')
	
	% Generate RT parameters
    rr_range_min=rr_range(1);
    rr_range_max=rr_range(2);
    rm_range_min=rm_range(1);
    rm_range_max=rm_range(2);
    
    rr = (rr_range_max-rr_range_min).*rand(1,sample_size) + rr_range_min;
    rm = (rm_range_max-rm_range_min).*rand(1,sample_size) + rm_range_min;
    
	% Generate electrode positions
	[x_pp,y_pp]=xy_point(Rmuscle,sample_size);
	z_pp= (Lmuscle).*rand(1,sample_size);
	
    para_inti = [rr;rm;x_pp;y_pp;z_pp];
    
end