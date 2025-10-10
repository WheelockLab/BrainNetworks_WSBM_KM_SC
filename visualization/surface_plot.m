addpath('/data/wheelock/data1/people/Ayoushman/WSBM_neuro_comm/support_functions');

%% load IM file
[~,sortID] = sort(IM.order);

%%

Explore_parcel_levels_HSB(IM.key(sortID,2),IM.cMap,...
    IM.Parcels, max(IM.key(:,2)),"your_file_name");
