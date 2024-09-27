function Model = Trainer_for_K_Classes(data,nof)

    K = length(data);
    W_list = zeros(size(data{1,1},1),nof,K-1);
    w_lda_list = zeros(nof,K-1);
    threshold_list = zeros(1,K-1);
    threshold_direction_list = zeros(1,K-1);
    X1 = [];  
    
    for k = 0:K-2
        
        
        
        X2 = data{1,end-k};
        for i = 1:K-1-k
            X1 = cat(3,X1,data{1,i});
        end

        [W_list(:,:,k+1),w_lda_list(:,k+1)...
            ,threshold_list(k+1),threshold_direction_list(k+1)] = ...
            Trainer_for_2_Classes(X1,X2,nof);
        X1 = [];

    end

    Model = {W_list,w_lda_list,threshold_list,threshold_direction_list};
        
end