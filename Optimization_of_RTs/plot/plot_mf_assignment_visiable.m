phi_circle = linspace(0, 2*pi, 1000)';
phi_circle = phi_circle(1:end-1); 

figure
suptitle('Detectable MUs'' innervation areas at final iteration');
subplot(1,2,1)
muscle_section = @(x,y) x.^2 + y.^2 - Rmuscle^2;
fimplicit(muscle_section,[-6 6 -6 6],'k-','LineWidth',2);
hold on
plot(mf_centers(:,1),mf_centers(:,2),'.','MarkerEdgeColor',[96/255 96/255 96/255],'MarkerSize',2);
hold on
for n=visuable_N
   hull=convhull(mf_center_to_each_mn{n}(:,1),mf_center_to_each_mn{n}(:,2)); 
   plot(mf_center_to_each_mn{n}(hull,1),mf_center_to_each_mn{n}(hull,2));
   text(mn_centers(n,1),mn_centers(n,2),num2str(n));
   hold on
end
plot(-2.5,0,'o','MarkerEdgeColor','k','MarkerFaceColor','[0.5,0.5,0.75]','MarkerSize',6);
title('Adding muscle fibre');
axis equal

subplot(1,2,2)
axis equal
muscle_section = @(x,y) x.^2 + y.^2 - Rmuscle^2;
fimplicit(muscle_section,[-6 6 -6 6],'k-','LineWidth',2);
hold on
for n=visuable_N
   hull=convhull(mf_center_to_each_mn{n}(:,1),mf_center_to_each_mn{n}(:,2)); 
   plot(mf_center_to_each_mn{n}(hull,1),mf_center_to_each_mn{n}(hull,2));
   text(mn_centers(n,1),mn_centers(n,2),num2str(n));
   hold on
end
plot(-2.5,0,'o','MarkerEdgeColor','k','MarkerFaceColor','[0.5,0.5,0.75]','MarkerSize',6);
title('Clear');
axis equal
