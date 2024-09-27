function [W,w_lda,threshold,threshold_direction] = Trainer_for_2_Classes(X1,X2,nof)
    
    K1 = size(X1,3);
    K2 = size(X2,3);

    Rx1 = mean(pagemtimes(X1,'none',X1,'transpose') , 3);
    Rx2 = mean(pagemtimes(X2,'none',X2,'transpose') , 3);
    
    [W , L] = eig(Rx1 , Rx2);
    W = normc(W);
    [~,ind] = sort(diag(L));
    W = W(:,ind);

    
    W = [ W( : , 1:nof/2 ) , W( : , end+1-nof/2 :end ) ];


    
    X1_feautures = squeeze( var(pagemtimes(W,'transpose',X1,'none'),0,2) );
    X2_feautures = squeeze( var(pagemtimes(W,'transpose',X2,'none'),0,2) );
   
%     scatter(X1_feautures(1,:),X1_feautures(2,:))
%     hold on
%     scatter(X2_feautures(1,:),X2_feautures(2,:))
    
    u1 = mean(X1_feautures,2);
    u2 = mean(X2_feautures,2);
    sig1 = 1/K1 * (X1_feautures - u1) * (X1_feautures - u1).';
    sig2 = 1/K2 * (X2_feautures - u2) * (X2_feautures - u2).';

    V1 = (u1 - u2) * (u1 - u2).';
    V2 = sig1 + sig2;

    [W_lda , L_lda] = eig(V1 , V2);
    W_lda = normc(W_lda);
    [~,ind] = sort(abs(diag(L_lda)));
    L_lda = L_lda(ind,ind);
    W_lda = W_lda(:,ind);

    w_lda = W_lda(:,end);
    threshold = 0.5 * (mean(w_lda.' * X1_feautures) + mean(w_lda.' * X2_feautures));
    if mean(w_lda.' * X2_feautures)>mean(w_lda.' * X1_feautures)
        threshold_direction = 0;
    else
        threshold_direction = 1;
    end
end