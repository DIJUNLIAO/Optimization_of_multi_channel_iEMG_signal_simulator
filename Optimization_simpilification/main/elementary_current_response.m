function H = elementary_current_response(za,ra,z,sigma_z,sigma_r)
    r=ra;
    H = 1/4/pi/sigma_r./sqrt((sigma_z/sigma_r).*(r^2) + (z-za).^2);
end
