phi_circle = linspace(0, 2*pi, 1000)';
phi_circle = phi_circle(1:end-1); 

figure
suptitle('Theoritical MUs'' innervation areas at final iteration');
subplot(1,2,1)
muscle_section = @(x,y) x.^2 + y.^2 - Rmuscle^2;
fimplicit(muscle_section,[-6 6 -6 6],'k-','LineWidth',2);
hold on
plot(mf_centers(:,1),mf_centers(:,2),'.','MarkerEdgeColor',[96/255 96/255 96/255],'MarkerSize',2);
hold on
for n=1:N
% for n=N
   rad = sqrt(sz(n)/sum(sz) * pi * Rmuscle^2/pi);
   mu_area_circle = [rad * cos(phi_circle) + mn_centers(n,1),rad * sin(phi_circle) + mn_centers(n,2)];
   plot(mu_area_circle(:,1), mu_area_circle(:,2));
   text(mn_centers(n,1),mn_centers(n,2),num2str(n));
   hold on
end
title('Adding muscle fibres');
axis equal

subplot(1,2,2)
muscle_section = @(x,y) x.^2 + y.^2 - Rmuscle^2;
fimplicit(muscle_section,[-6 6 -6 6],'k-','LineWidth',2);
hold on
for n=1:N
% for n=N
   rad = sqrt(sz(n)/sum(sz) * pi * Rmuscle^2/pi);
   mu_area_circle = [rad * cos(phi_circle) + mn_centers(n,1),rad * sin(phi_circle) + mn_centers(n,2)];
   plot(mu_area_circle(:,1), mu_area_circle(:,2));
   text(mn_centers(n,1),mn_centers(n,2),num2str(n));
   hold on
end
title('Clear');
axis equal

figure
suptitle('Real MUs'' innervation areas at final iteration');
subplot(1,2,1)
muscle_section = @(x,y) x.^2 + y.^2 - Rmuscle^2;
fimplicit(muscle_section,[-6 6 -6 6],'k-','LineWidth',2);
hold on
plot(mf_centers(:,1),mf_centers(:,2),'.','MarkerEdgeColor',[96/255 96/255 96/255],'MarkerSize',2);
hold on
for n=1:N
    if optiz_mode==3
        hull=convhull(mf_center_to_each_mn_best{n}(:,1),mf_center_to_each_mn_best{n}(:,2)); 
        plot(mf_center_to_each_mn_best{n}(hull,1),mf_center_to_each_mn_best{n}(hull,2));
    else
        hull=convhull(mf_center_to_each_mn{n}(:,1),mf_center_to_each_mn{n}(:,2)); 
        plot(mf_center_to_each_mn{n}(hull,1),mf_center_to_each_mn{n}(hull,2));
    end
    text(mn_centers(n,1),mn_centers(n,2),num2str(n));
    hold on
end
title('Adding muscle fibres');
axis equal

subplot(1,2,2)
axis equal
muscle_section = @(x,y) x.^2 + y.^2 - Rmuscle^2;
fimplicit(muscle_section,[-6 6 -6 6],'k-','LineWidth',2);
hold on
for n=1:N
    if optiz_mode==3
        hull=convhull(mf_center_to_each_mn_best{n}(:,1),mf_center_to_each_mn_best{n}(:,2)); 
        plot(mf_center_to_each_mn_best{n}(hull,1),mf_center_to_each_mn_best{n}(hull,2));
    else
        hull=convhull(mf_center_to_each_mn{n}(:,1),mf_center_to_each_mn{n}(:,2)); 
        plot(mf_center_to_each_mn{n}(hull,1),mf_center_to_each_mn{n}(hull,2));
    end
   text(mn_centers(n,1),mn_centers(n,2),num2str(n));
   hold on
end
plot(-2.5,0);
title('Clear');
axis equal
