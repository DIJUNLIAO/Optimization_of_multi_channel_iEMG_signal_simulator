function H = elementary_current_response(mf_center,za,x,y,z,sigma_z,sigma_r,min_radial_dist)
    r = sqrt((x-mf_center(1)).^2+(y-mf_center(2)).^2);
    r(r < min_radial_dist) = min_radial_dist;
    H = 1/4/pi/sigma_r./sqrt((sigma_z/sigma_r).*(r^2) + (z-za).^2);
end
