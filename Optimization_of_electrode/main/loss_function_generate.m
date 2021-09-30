function loss_function = loss_function_generate(Y,muap)
    loss_function_series = (Y(:,1)-muap).^2;
    loss_function = sum(loss_function_series);
end