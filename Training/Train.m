clc,clear,close all;

nof = [8 8 12 2 4 , 6 8 6 6 8 , 8 8 10 10 8];

cd ..\filtered_dataset

files = dir;
N = numel(files);

for n = 3:N

    Name = files(n).name;
    load(Name)
        
    cd ..\Training
    
    Model = Trainer_for_K_Classes(data,nof(str2num(Name(6:end-4))));
    
    savePath = ['..\Model\Parameters\Model_',files(n).name];
    save(savePath,'Model')
    cd ..\filtered_dataset

end