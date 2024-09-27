function Class_list = Classify(data,Subject_no,external_Model)
    
    c = class(external_Model);
    c = c(1);
    if c ~= 'c'
        load(['Parameters\Model_subj_',num2str(Subject_no),'.mat']);
    else
        Model = external_Model;
    end
    
    W_list = Model{1,1};
    w_lda_list = Model{1,2};
    threshold_list = Model{1,3};
    threshold_direction_list = Model{1,4};

    Class_list = ones(1,size(data,3));
    flag_list = zeros(1,size(data,3));
    
    for k = 1:size(W_list,3)
            
        test_set = squeeze( var(pagemtimes(W_list(:,:,k),'transpose',data,'none'),0,2) );
        image = w_lda_list(:,k).' * test_set;
        
        if(threshold_direction_list(k) == 0)
            Class_list(image>threshold_list(k) &...
                flag_list == 0)...
                = size(W_list,3)+2-k;
            flag_list(image>threshold_list(k) &...
                flag_list==0)...
                = 1;
        else
            Class_list(image<threshold_list(k) &...
                flag_list == 0)...
                = size(W_list,3)+2-k;
            flag_list(image<threshold_list(k) &...
                flag_list==0)...
                = 1;
        end
        
    end
            
end
