function I = elementary_current_source(zi,mf_cv,t,dz,za,mfr,sigma_i)
    
    L_right = 30-zi;
    L_left = zi;
    
    suppress_endplate_density = 1;
    endplate_width = 0.5;
    
    z1 = [za(:);za(end)+dz];
    
    [T,Z] = meshgrid(t,z1);
    
    tendon_terminator = @(z_inti, L_inti) z_inti<=L_inti/2 & z_inti>=-L_inti/2;
    
    if L_right>=L_left
        Zf=-2*(Z-zi-mf_cv*T);
        Zpf = Zf(Zf >0);
        dV=nan(size(Zf));
        dV(Zf>0) = (96 * (3*(Zpf.^2)-(Zpf.^3)).*exp(-Zpf));
        dV(Zf<=0) = 0;
        psi = -4*dV;
        longest_wave = diff(psi)/ dz;
        longest_wave = longest_wave .* tendon_terminator(Z(1:end-1,:)-zi-L_right/2, L_right);
        longest_wave = longest_wave .* ((Z(1:end-1, :) - zi)./mf_cv > 0);

    else
        Zf=-2*(-Z+zi-mf_cv*T);
        Zpf = Zf(Zf >0);
        dV=nan(size(Zf));
        dV(Zf>0) = (96 * (3*(Zpf.^2)-(Zpf.^3)).*exp(-Zpf));
        dV(Zf<=0) = 0;
        psi = 4*dV;
        longest_wave = diff(psi)/ dz;
        longest_wave = longest_wave .* tendon_terminator(Z(1:end-1,:)-zi+L_left/2, L_left);
        longest_wave = longest_wave .* ((-Z(1:end-1, :) + zi)/mf_cv > 0);

    end
    
    shortest_wave = longest_wave(end:-1:1,:);
    
    shifting_step = round((L_right + L_left - max(z1) + L_left - L_right)/dz);
    shortest_wave = circshift(shortest_wave, shifting_step, 1);
    shortest_wave(1:shifting_step) = 0;
    shortest_wave(end+shifting_step+1:end) = 0;

    if L_right>=L_left
        shortest_wave = shortest_wave .* tendon_terminator(Z(1:end-1,:)-zi+L_left/2, L_left);
        iap = longest_wave-shortest_wave;
    else
        shortest_wave = shortest_wave .* tendon_terminator(Z(1:end-1,:)-zi-L_right/2, L_right);
        iap = shortest_wave-longest_wave;
    end
    
    if suppress_endplate_density
        endplate_terminator = @(z_inline) z_inline <= (zi-endplate_width) | z_inline >= (zi+endplate_width);
        iap = iap .* endplate_terminator(Z(1:end-1, :));
    end
    
    
    mmfr = mfr*1000;
    I = iap * sigma_i * pi * ((mmfr)^2)/4;
    
end