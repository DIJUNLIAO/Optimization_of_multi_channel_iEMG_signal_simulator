% clear all
% load('C:\Users\dl1920\Desktop\optimization_electrode_version_2\op_inti.mat')


n=15;
syms xpp ypp zpp zf
z_left = nmj_z(1):-dz:0;
z_right = nmj_z(1):dz:30;
za = transpose([z_left(end:-1:1), z_right(2:end)]);
HH = 1/4/pi/sigma_r/sqrt((sigma_z/sigma_r)*((mf_center(1,1)-xpp)^2+(mf_center(1,2)-ypp)^2) + sum((za-zpp).^2));
HH_v=matlabFunction(HH);



xdx = diff(HH,xpp);
dHdx=matlabFunction(xdx);
dHdx_val = dHdx(-2.5,0,15);

ydy = diff(HH,ypp);
dHdy=matlabFunction(ydy);
dHdy_val = dHdy(-2.5,0,15);

zdz = diff(HH,zpp);
dHdz=matlabFunction(zdz);
dHdz_val = dHdz(-2.5,0,15);

x1=logspace(-n,1);

for k = 1:size(x1,2)
    complex_step = 10^(x1(k));
    
    HH_vv=HH_v(1,1,15);
    HH_vcx=HH_v(1+sqrt(-1)*complex_step,1,15);
    HH_vcy=HH_v(1,1+sqrt(-1)*complex_step,15);
    HH_vcz=HH_v(1,1,15+sqrt(-1)*complex_step);
    
    dHdx_c=imag(HH_vcx)/complex_step;
    dHdy_c=imag(HH_vcy)/complex_step;
    dHdz_c=imag(HH_vcz)/complex_step;
    
    absolute_error_x(k) = abs(dHdx_val-dHdx_c);
    absolute_error_y(k) = abs(dHdy_val-dHdy_c);
    absolute_error_z(k) = abs(dHdz_val-dHdz_c);
    
end


figure
loglog(x1,absolute_error_x,'-b',x1,absolute_error_y,'-r',x1,absolute_error_z,'-g','LineWidth',2);
title('\bf Absolute error using complex step method to estimate gradient of H',{['$H(x,y,z)=\frac{1}{4\pi\sigma_r}\times\frac{I_e}{\sqrt{[(x-x_f)^2+(y-y_f)^2]\times\frac{\sigma_s}{\sigma_r}+(z-Z_f)^2}}$, ($I_e$ is a constant after calculation of IAP)'];['Muscle Fiber Number=1'];['Muscle Fiber Position=(',num2str(mf_center(1,1)),',',num2str(mf_center(1,2)),',',num2str(nmj_z(1)),')'];['Electrode Position=(-2.5,0,15)']},'interpreter','latex');
xlabel('time/s');
ylabel('Absolute Error');
leg = legend('Absolute Error of $\frac{\partial H}{\partial x}$','Absolute Error of $\frac{\partial H}{\partial y}$', 'Absolute Error of $\frac{\partial H}{\partial z}$');
set(leg,'Interpreter','latex');
grid on
