function plot_acc_distribution_null_space

    % 10th Order
    %load('result_b3000_testing_10th_order.mat')
    load('check_1.mat')
    %load('result_b9000_testing_10th_order.mat')
    %load('result_b12000_testing_10th_order.mat')
    
    %load('result_testing_10th_order_all_shells.mat')
    
    %load('my_outcome_testing_6th_order.mat')
    %load('my_outcome_testing_8th_order.mat')
    %load('out_matrix.mat')
    
    %load('CSDmatrix.mat')
    
    %dims = size(out_pred);
    dims = [7272 66];
    
    mse_vector = zeros(dims(1),1);
    acc_vector = zeros(dims(1),1);
    %csd_acc_vector = zeros(dims(1),1);
    
    out_pred = out_pred(:,133:end);
    out_pred = double(out_pred);
    
    % Taking the last 7267 voxels from out_matrix
    %out_true_orig = out_matrix(49996:57267,:);
    out_true_orig = out_true;
    %out_csd_preds = CSDmatrix(49996:57267,:);
    
    
    %true_gfa_vector = zeros(dims(1),1);
    %pred_gfa_vector = zeros(dims(1),1);
    
    for i=1:dims(1)
        % MSE
        mse_vector(i,1) = immse(out_true(i,:),out_pred(i,:));
        % ACC
        
        % Pad the predictions with zeros up till 10th order or 66 coeffs
        % for fair comparison
        
        pred_temp = out_pred(i,:);
        pred_dims = size(pred_temp);
        if (pred_dims(2) ~= 66)
           padder = pred_dims(2) + 1;
           pred_temp(padder:66) = 0;
        end
        %pred_temp(29:66) = 0;
        
        %csd_pred_temp = out_csd_preds(i,:);
        %csd_pred_temp(46:66) = 0;
        
        acc_vector(i,1) = angularCorrCoeff(out_true_orig(i,:),pred_temp);
        %csd_acc_vector(i,1) = angularCorrCoeff(out_true_orig(i,:),csd_pred_temp);
        
        % True GFA
        %true_gfa_vector(i,1) = calcGFA(out_true_orig(i,:));
        %pred_gfa_vector(i,1) = calcGFA(pred_temp);
    end
    
    %diff_gfa_vector = true_gfa_vector - pred_gfa_vector;

    figure
    subplot(1,2,1)
    hist(acc_vector,100)
    %ylim([0 800])
    %xlim([0 1])
    grid on
    hold on
    med = median(acc_vector);
    men = mean(acc_vector);
    line([med,med],[0,800],'color','red')
    ylabel('Number of Voxels')
    xlabel('ACC')
    dl_title_name = sprintf('ACC b/w True and Pred, Median - %0.4f',med);
    title(dl_title_name)
    
    %{
    subplot(1,3,3)
    hist(csd_acc_vector,100)
    xlim([0 1])
    grid on
    hold on
    ylabel('Number of Voxels')
    xlabel('ACC')
    med_csd = median(csd_acc_vector);
    men_csd = mean(csd_acc_vector);
    line([med_csd,med_csd],[0,800],'color','red')
    csd_title_name = sprintf('CSD ACC b/w True and Pred, Median - %0.4f',med_csd);
    title(csd_title_name)
    %}
    
    subplot(1,2,2)
    hist(mse_vector,100)
    grid on
    ylabel('Number of Voxels')
    xlabel('Mean Squared Error')
    title('MSE dist b/w True and Pred')
    ylim([0 800])
    set(gca,'Xtick',0:0.005:0.02)
    
    %{
    subplot(2,2,4)
    dat = [acc_vector,mse_vector];
    n = hist3(dat,[20 20]); % default is to 10x10 bins
    n1 = n';
    n1(size(n,1) + 1, size(n,2) + 1) = 0;
    %Generate grid for 2-D projected view of intensities.
    xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
    yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);
    %Make a pseudocolor plot.
    h = pcolor(xb,yb,n1);
    colormap jet
    colorbar
    ylabel('MSE')
    xlabel('ACC')
    title('Heat Map ACC vs MSE w No.of Voxels')
    %}
    
end