figure
plot(loss_function_all_i(2,:),loss_function_all_i(1,:),'.','MarkerFaceColor','w');
text(loss_function_all_i(2,:),loss_function_all_i(1,:),num2cell(reconstruct_index_f));
hold on
xlabel('Objective function 2');
ylabel('Objective function 1');

title('NSGA-II loss function distrubuation');

figure
for i=1:size(solve_level,2)
    n=0;
    clear XX YY 
    for k=solve_level{i}
        n=n+1;
        XX(n)=loss_function(2,k);
        YY(n)=loss_function(1,k);
    end
    plot(XX,YY,'o-','LineWidth',2,'MarkerFaceColor','w');
    text(XX,YY,num2cell(solve_level{i}));
    hold on
end

xlabel('Objective function 2');
ylabel('Objective function 1');

title('NSGA-II loss function dominated level of each objective pair');