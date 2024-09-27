clc,clear,close all;

load Filters.mat
load Useful_Channels.mat

Useful_Channels = {1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   Useful_Channels ,...
                   1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   1:63 ,...
                   Useful_Channels ,...
                   1:63};

Filters = {'5_25' , '5_25' , '5_30' , '10_25' , '10_25' ...
         , '5_30' , '10_25' , '8_70' , '8_50' , '5_30' ...
         , '8_70' , '8_20' , '20_50' , '8_70' , '8_60'};

cd ..\dataset

files = dir;
N = numel(files);

%fitering each channel in all of data with BP filter 
% and saving filtered data in a new folder


for n = 3:N
    
    Name = files(n).name;
    load(Name)
    Hd = eval(['Hd_',Filters{str2num(Name(6:end-4))}]);

    for c = 1:length(data)
        d = data{c};
        d = d(Useful_Channels{str2num(Name(6:end-4))},:,:);
        for s = 1:size(d,3)
                d(:,:,s) = filter(Hd,d(:,:,s).').';
        end
        data{c} = d;
    end

    
    cd ..
    cd filtered_dataset
    savePath = Name; 
    save(savePath,'data')
    cd ..;
    cd dataset
    
end


cd ..\Preprocessing
