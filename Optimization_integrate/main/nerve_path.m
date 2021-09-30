% Generate nerve path from MN center to branches point and branches point to arborization point
% This is used to simulate the axons

function nerve_paths = nerve_path(actual_center,cluster_center,nmj_xyz,nmj_z,N)
    nerve_paths=cell(1,N);
    for n=1:N
        for i=1:size(nmj_z{n},2)
            nerve_paths{n}(i,1) = norm(actual_center(n,:) - cluster_center{n}(i,:));
            nerve_paths{n}(i,2) = norm(nmj_xyz{n}(i,:) - cluster_center{n}(i,:));
        end
    end
end