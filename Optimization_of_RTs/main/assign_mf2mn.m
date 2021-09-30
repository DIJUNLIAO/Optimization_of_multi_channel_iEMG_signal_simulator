% Optimization of MN terratories and MF innervation via Recruiment Thershould
% Assign MF to specific MN

function [mf_N_rec,mf_assign_to_mn,mf_center_to_each_mn]= assign_mf2mn(mf_number,mn_inv_area,mn_inv_number,N,mf_center,mn_center, Rmuscle)

    mf_center_to_each_mn = cell(1,120);
    mf_N_rec = randperm(mf_number);
    
    % Set neighbours (when n of current MFs nearest neighbors has been assigned to a specific MN, then this MF will not assign to that MN)
    n_neighbours = 3;
    
	% Use k-nn to find neighbors
    neighbours = knnsearch(mf_center, mf_center, 'K', n_neighbours+1);
    neighbours = neighbours(:,2:end);
	
    mf_assign_to_mn = zeros(mf_number,1);
    mn_assign_number=zeros(N,1);
	
	% Get a out of boundary coefficient to avoid densities errors 
    c =  chi2inv(0.99,2);
    sigma = @(ia) eye(2) * ia / pi / c;
    borderfun_pos = @(x)real( sqrt(Rmuscle^2 - x.^2));
    borderfun_neg = @(x)real(-sqrt(Rmuscle^2 - x.^2));
    out_circle_coeff = ones(N,1);
    
	% Get the probability that used to represent the position relationships between MN and MF
    for mu = 1:N
        probfun = @(x,y) reshape(mvnpdf([x(:), y(:)], mn_center(mu,:), sigma(mn_inv_area(mu))), size(x));
        in_circle_int = integral2(probfun, -Rmuscle, Rmuscle, borderfun_neg, borderfun_pos);
        out_circle_coeff(mu) = 1/in_circle_int;
    end
    
	% Generate final assignment probabilities
    tp=0;
    for i=mf_N_rec
        tp=tp+1;
        probs = zeros(N,1);
        for n=1:N
		
			% if any neighbors has been assigned, equal to 0
            if n_neighbours && any(mf_assign_to_mn(neighbours(i,:)) == n)
                probs(n) = 0;
            else
                apriori_prob = mn_inv_number(n)/N; % priory probability, used to represent MN size
                probs(n) = apriori_prob*mvnpdf(mf_center(i,:)', mn_center(n,:)', sigma(mn_inv_area(n)))*out_circle_coeff(n); % full assignment probability

            end
        end
		
		% Random assign MFs to MN
        mf_assign_to_mn(i) = randsample(N,1,true,probs/sum(probs));
        mn_assign_number(mf_assign_to_mn(i))=mn_assign_number(mf_assign_to_mn(i))+1;
        mf_center_to_each_mn{mf_assign_to_mn(i)}(end+1,:) = mf_center(i,:);
    end
end