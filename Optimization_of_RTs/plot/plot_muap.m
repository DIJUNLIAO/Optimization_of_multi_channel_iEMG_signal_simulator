figure
sgtitle('Real, initial and optimized MUAPs for detectable MU=28');
% sgtitle('Real, initial and optimized MUAPs for detectable MUs');
i=0;
for n=visuable_N(1:2)
% for n=visuable_N
   i=i+1;
   subplot(2,1,i);
   
   X1=0:dt:(size(Y{i},1)-1)*dt;
   pp{1}= plot(X1,Y{i},'-b','LineWidth',2);
   hold on

   X2=0:dt:(size(muap_best{i},1)-1)*dt;
   pp{2}= plot(X2,muap_best{i},'-m','LineWidth',2);
   grid on 

   grid on 
   xlabel('t/s');
   ylabel('Potential');
end

legend([pp{1},pp{2}],'Real MUAPs','Best MUAPs','location',[0.49,0.10,0.61,0.17]);
