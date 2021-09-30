if opt_mode == 1
    mode_para='Gradient Descent';
elseif opt_mode == 2
    mode_para='Adam';
elseif opt_mode == 3
    mode_para='Quasi-Newton (DFP)';
elseif opt_mode == 4
    mode_para='Quasi-Newton (BFGS)';
end

figure
grid on
X1=0:1:loop_nm-2;
plot(X1,object_value_all(1:end),'-ob','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','y');
title('\bf Optimization Result of MU',{['MU number=',num2str(MU_number)];['Optimization Mode=',mode_para];['Initial Electrode Position=(',num2str(p_current(1,1)),',',num2str(p_current(2,1)),',',num2str(p_current(3,1)),')'];['Final Electrode Position=(',num2str(p_current(1,end)),',',num2str(p_current(2,end)),',',num2str(p_current(3,end)),')'];['Minimum Value of Loss Function=',num2str(object_value_all(end-1))];['Iteratation times=',num2str(loop_nm-2)];['Optimization running times=',num2str(time_opti),'s'];['Learning Ratio=',num2str(alpha_value)]},'Interpreter','latex');
xlabel('Optimization number');
ylabel('Loss function value');
legend('Each Optimization Step');

figure
grid on
X2=0:dt:(2 * max([nmj_z./v ; (30 - nmj_z)./v]));

plot(X2,Y,'-b','LineWidth',2);
hold on
plot(X2,muap_first,'-g','LineWidth',2);
hold on
plot(X2,muap,'-m','LineWidth',2)
title('\bf Real and optimized MUAP at first and final iteratation of MU',{['MU number=',num2str(MU_number)];['Optimization Mode=',mode_para];['Initial Electrode Position=(',num2str(p_current(1,1)),',',num2str(p_current(2,1)),',',num2str(p_current(3,1)),')'];['Final Electrode Position=(',num2str(p_current(1,end)),',',num2str(p_current(2,end)),',',num2str(p_current(3,end)),')'];['Minimum Value of Loss Function=',num2str(object_value_all(end-1))];['Iteratation times=',num2str(loop_nm-2)];['Optimization running times=',num2str(time_opti),'s'];['Learning Ratio=',num2str(alpha_value)]},'Interpreter','latex');
xlabel('time/s');
ylabel('Potential');
legend('Real MUAP (Y)','Simulated MUAP before optimized (muap(1))', 'Simulated MUAP after optimized (muap(end))');

figure
grid on
[X3,Y1,Z1] = cylinder(Rmuscle);
Z1=Z1*Lmuscle;
surf(Z1,Y1,X3,'FaceAlpha',.5,'FaceColor','c','LineStyle','none');
hold on
plot3(p_current(3,:),p_current(2,:),p_current(1,:),'o-k','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','y');
title('\bf Position of Electrode of MU',{['MU number=',num2str(MU_number)];['Optimization Mode=',mode_para];['Initial Electrode Position=(',num2str(p_current(1,1)),',',num2str(p_current(2,1)),',',num2str(p_current(3,1)),')'];['Final Electrode Position=(',num2str(p_current(1,end)),',',num2str(p_current(2,end)),',',num2str(p_current(3,end)),')'];['Minimum Value of Loss Function=',num2str(object_value_all(end-1))];['Iteratation times=',num2str(loop_nm-2)];['Optimization running times=',num2str(time_opti),'s'];['Learning Ratio=',num2str(alpha_value)]},'Interpreter','latex');
xlabel('z-axis');
ylabel('y-axis');
zlabel('x-axis');
legend('Muscle Border','Electorde Position after each optimization','Location','northwest');
axis equal