% MU innervation area

function [mn_inv_number,mn_inv_area] = innveration_area(sz,Rmuscle,Dmf)
    muscle_area = pi*Rmuscle^2;
    mn_inv_area = sz.*muscle_area/4;
    mn_inv_number = round(mn_inv_area./sum(mn_inv_area).*muscle_area.*Dmf);
end