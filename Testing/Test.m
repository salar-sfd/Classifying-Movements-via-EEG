clc,clear,close all;

cd ..\filtered_dataset

nof = [8 8 12 2 4 , 6 8 6 6 8 , 8 8 10 10 8];

files = dir;
N = numel(files);

cm_train_sum = zeros(4,4);
cm_test_sum = zeros(4,4);

for n = 3:N
    
    Name = files(n).name;
    load(Name)
    
    cd ..\training
    
    train_Label = [];
    test_Label = [];
    estimated_train_Label = [];
    estimated_test_Label = [];
    
    for iteration = 1:100
        
        cd ..\training
        
        train_data_cell = cell(1,length(data));
        train_data = [];
        test_data = [];

        for class_no = 1:length(data)
            
            D = data{1,class_no};
            trials_no = size(data{1,class_no},3);
            L = randi(trials_no);
            train_data_cell{1,class_no} = D(:,:,(1:trials_no)~=L);
            train_data = cat(3,train_data,D(:,:,(1:trials_no)~=L));
            train_Label = cat(2,train_Label,class_no*ones(1,size(D(:,:,(1:trials_no)~=L),3)));
            test_data = cat(3,test_data,D(:,:,L));

        end
        test_Label = cat(2,test_Label,1:4);

        Model = Trainer_for_K_Classes(train_data_cell,nof(str2num(Name(6:end-4))));
        
        cd ..\Model
        estimated_train_Label = cat(2,estimated_train_Label,Classify(train_data,[],Model));
        estimated_test_Label = cat(2,estimated_test_Label,Classify(test_data,[],Model));
        
        message = sprintf('Subject %d\nProcessing iteration %d/100', str2num(Name(6:end-4)),iteration);
        clc
        disp(message)
    end

    cm_train = confusionmat(train_Label, estimated_train_Label);
    cm_test = confusionmat(test_Label, estimated_test_Label);

    cm_train_sum = cm_train_sum+cm_train;
    cm_test_sum = cm_test_sum+cm_test;
        
    subplot(4,8,(str2num(Name(6:end-4))*2-1)),confusionchart(cm_train),title(['Train Data ',Name(6:end-4)])
    subplot(4,8,(str2num(Name(6:end-4))*2)),confusionchart(cm_test),title(['Test Data ',Name(6:end-4)])
    
    cd ..\filtered_dataset

end

subplot(4,8,31) , cm = confusionchart(cm_train_sum); title('Train Data Sum')
subplot(4,8,32) , cm = confusionchart(cm_test_sum); title('Test Data Sum')

figure
subplot(1,2,1) , cm = confusionchart(cm_train_sum) ; cm.RowSummary = 'row-normalized' ; title('Train Data Sum')
subplot(1,2,2) , cm = confusionchart(cm_test_sum) ; cm.RowSummary = 'row-normalized' ; title('Test Data Sum')

cd ..\Testing