figure
sgtitle('Real, initial and optimized selected MUAPs for detectable MUs');
i=0;
for n=visuable_N(1:2)
% for n=visuable_N
	i=i+1;
	subplot(2,1,i);
   
	X1=0:dt:(size(Y{i},1)-1)*dt;
	pp{1}= plot(X1,Y{i},'-b','LineWidth',2);
	hold on
	for i=1:parameter_sample_size
		X2=0:dt:(size(muap{i},1)-1)*dt;
		pp{2}= plot(X2,muap{i});
		hold on
	end
	grid on 
	xlabel('t/s');
	ylabel('Potential');
end
