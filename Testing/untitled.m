clc,clear,close all;

cd ..\filtered_dataset

files = dir;
N = numel(files);
external_Model = [];

for n = 3:N
    
    Name = files(n).name;
    load(Name)
    
    cd ..\Model
    
    figure
    
    for k = 1:length(data)
        subplot(length(data),1,k);
        Class_list = Classify(data{1,k},Name(6:end-4),external_Model);
        stem(Class_list)
        ylim([0 4]);
        title(sum(Class_list == k) / length(Class_list))
    end
    
    cd ..\filtered_dataset
    
end
%%
for i = 1:15
    load(['..\filtered_dataset\subj_',num2str(i),'.mat']);
    cd ..\training
    subplot(4,4,i)
    X1 = cat(3,data{1,1});
    X2 = data{1,2};
    Trainer_for_2_Classes(X1(Useful_Channels,:,:),X2(Useful_Channels,:,:),16);
end