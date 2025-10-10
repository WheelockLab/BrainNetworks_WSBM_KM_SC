% This code creates a fc matrix from any mean and variance matrix
% We have used HCP data for illustration purpose

%% add necessary file paths

addpath('/data/wheelock/data1/people/Ayoushman/WSBM_neuro_comm/support_functions')

%% load the data

% HCP data
data_path = '/data/wheelock/data1/datasets/HCP/HCP_965_10min_Gordon333_20221123/mat/HCP_965_10min_Gordon333_20221123_Rest1.mat';
load(data_path);
fcmat = HCPRest1;
clear HCPRest1 data_path;
ave_fcmat = mean(tanh(fcmat),3); % average fc matrix

% load Gordon atlas
load('IM_Gordon_2014_333_Parcels.mat');

%addpath('/data/wheelock/data1/software/Aicher_2015_WSBM/WSBM_v1.3')
%addpath('/data/wheelock/data1/software/Aicher_2015_WSBM/WSBM_v1.3/private')

%% data processing 

% order the fc matrix according to Gordon atlas
ave_fcmat = ave_fcmat(IM.order, IM.order);
mat_plot(ave_fcmat);

% frequency distribution of the community memberships
tab = tabulate(IM.key(:,2));
tab(:,4) = cumsum(tab(:,2));
tab = [0 0 0 0; 
    tab];

% Find the community mean and variance matrix
ave_fcmat_mu = [];
ave_fcmat_sigma = [];
for ii = 1:max(max(IM.key(:,2)))
    for jj = 1:max(max(IM.key(:,2)))
        % find the sub_matrix with community pair (ii,jj)
        sub_mat = ave_fcmat((tab(ii,4)+1):tab(ii+1,4), (tab(jj,4)+1):tab(jj+1,4));
        off_diag = [];
       if ii == jj
           % delete the diagonal elements containing 1 for ii = jj
           for kk = 1:length(sub_mat)-1
               off_diag = [off_diag, diag(sub_mat, kk)'];
           end
       else
           off_diag = reshape( sub_mat,1, numel(sub_mat));
       end
       ave_fcmat_mu(ii,jj) = mean(off_diag); % compute the mean 
       ave_fcmat_sigma(ii,jj) = var(off_diag);%
    end
end
clear ii jj kk sub_mat off_diag;

% plots of matrices
mat_plot(ave_fcmat_mu);
mat_plot(ave_fcmat_sigma);

%% simulation setting

% number of communities 
K = 5;

% mean matrix 
mu_mat = [0.3 0.2 0.1 -0.4 0.4;
        0.2 0.3 0.2 -0.3 -0.4;
         0.1 0.2 0.35 -0.01 -0.2;
         -0.4 -0.3 -0.01 0.4 0.1;
         0.4 -0.4 -0.2 0.1 0.3];

% generate the variance matrix

% diagonalize the variance matrix 
on_diag_sig = diag(ave_fcmat_sigma, 0)';
off_diag_sig = [];
for kk = 1:length(ave_fcmat_sigma)-1
    off_diag_sig = [off_diag_sig, diag(ave_fcmat_sigma, kk)'];
end
clear kk;

% samplethe values from ave_fcmat_sigma and retain the diagonal structure
rng(123)
sigma_mat = [];
for ii=1:K
    for jj=ii:K
        if ii==jj
            sigma_mat(ii,jj) = randsample(on_diag_sig, 1);
        else
            sigma_mat(ii,jj) = randsample(off_diag_sig, 1);
            sigma_mat(jj,ii) = sigma_mat(ii,jj);
        end
        
    end
end
clear ii jj on_diag_sig off_diag_sig;

% plots of matrices
mat_plot(mu_mat);
mat_plot(sigma_mat);

% True communitity label
label_true = repelem(1:K, [30 15 25 20 10]);
% number of ROI
nROI = 100;
% number of subjects
n = 1;

% generate the fc matrix
rng(123)
A = generate_fcmat(nROI, label_true, mu_mat, sigma_mat, n);

% save the data
sim.mat = A;
sim.mu = mu_mat;
sim.sigma = sigma_mat;
sim.label = label_true;
filename = sprintf('your_file_name_%s.mat', datestr(datetime,'yyyymmdd'));
save(filename, "sim");

