function Big_Data = Merge_Datas(Useful_Channels)

    cd ..\filtered_dataset

    files = dir;
    N = numel(files);

    %mixing all subjects cells into one cell 
    
    for n = 3:N
        load(files(n).name)
        if n==3
            Big_Data = cell(1,length(data));
        end
        for i = 1:length(data)
            x = data{1,i};
            Big_Data{1,i} = cat(3,Big_Data{1,i},x(Useful_Channels,:,:));
        end
    end

    cd ..\Training
    
end