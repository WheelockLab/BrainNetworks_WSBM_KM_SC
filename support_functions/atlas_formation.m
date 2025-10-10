%% SC and Kmeans
[~,sortID] = sort(group_idx');
xxx = IM_new.Key(sortID,2);

Explore_parcel_levels_HSB(xxx,customcolor(net_seq,:),...
    Parcels,k,fullfile(outputdir_plot,'hcp_sc_'));

Matrix_Org3(mat_order, IM.key, 10 , [-0.3, 0.3], IM.cMap, 1);


IM.name = 'BCP_SC_15_Gordon_333_Parcels_2014';
IM.key = IM_new.Key;
IM.order = group_idx';
IM.Nets = [];
IM.cMap = customcolor(net_seq,:);
IM.Parcels = Parcels;

save(fullfile('/data/wheelock/data1/people/Ayoushman/WSBM_neuro_comm/atlases', ...
    'BCP_SC_15_Gordon_333_Parcels_2014.mat'),'IM');


%% WSBM

IM.name = 'BCP_WSBM_15_Gordon_333_Parcels_2014';
IM.key = IM_new.Key;
IM.order = group_idx';
IM.Nets = [];
IM.cMap = new_customcolor;
IM.Parcels = Parcels;

save(fullfile('/data/wheelock/data1/people/Ayoushman/WSBM_neuro_comm/atlases', ...
    'BCP_WSBM_15_Gordon_333_Parcels_2014.mat'),'IM');


%% WSBM consensus


group_idx = [];
for i = 1:k
    group_idx = [group_idx, sort(find(renew_consensus_wsbm(:,k) == i)')];
end
clear i;

IM_new.Key(1:333,1) = 1:333;
IM_new.Key(1:333,2) = renew_consensus_wsbm(group_idx,k);


IM.name = sprintf('WU120_WSBM_consensus_%d_Gordon_333_Parcels_2014',k);
IM.key = IM_new.Key;
IM.order = group_idx';
IM.Nets = [];
IM.cMap = new_customcolor;
IM.Parcels = Parcels;

save(fullfile('/data/wheelock/data1/people/Ayoushman/WSBM_neuro_comm/atlases', ...
    sprintf('WU120_WSBM_consensus_%d_Gordon_333_Parcels_2014.mat',k)),'IM');
