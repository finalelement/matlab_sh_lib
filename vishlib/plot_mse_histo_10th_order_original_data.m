function plot_mse_histo_10th_order_original_data
    %load('my_outcome_testing_4th_order.mat')
    %load('my_outcome_testing_6th_order.mat')
    %load('my_outcome_testing_8th_order.mat')
    %load('my_outcome_testing_10th_order.mat')
    load('DL_single_shell_10th_order_original.mat')
    %load('out_matrix.mat')
    load('original_csd_matrix.mat')
    
    dims = size(out_pred);
    
    mse_vector = zeros(dims(1),1);
    acc_vector = zeros(dims(1),1);
    csd_acc_vector = zeros(dims(1),1);
    
    out_pred = double(out_pred);
    
    % Taking the last 7267 voxels from out_matrix
    out_true_orig = out_true(:,:);
    out_csd_preds = csd_matrix(:,:);
    
    
    true_gfa_vector = zeros(dims(1),1);
    pred_gfa_vector = zeros(dims(1),1);
    
    for i=1:dims(1)
        % MSE
        mse_vector(i,1) = immse(out_true(i,:),out_pred(i,:));
        % ACC
        
        % Pad the predictions with zeros up till 10th order or 66 coeffs
        % for fair comparison
        
        pred_temp = out_pred(i,:);
        %pred_temp(46:66) = 0;
        
        csd_pred_temp = out_csd_preds(i,:);
        csd_pred_temp(46:66) = 0;
        
        acc_vector(i,1) = angularCorrCoeff(out_true_orig(i,:),pred_temp);
        csd_acc_vector(i,1) = angularCorrCoeff(out_true_orig(i,:),csd_pred_temp);
        
        % True GFA
        true_gfa_vector(i,1) = calcGFA(out_true_orig(i,:));
        pred_gfa_vector(i,1) = calcGFA(pred_temp);
    end
    
    diff_gfa_vector = true_gfa_vector - pred_gfa_vector;

    figure
    subplot(1,3,1)
    hist(mse_vector,100)
    grid on
    ylabel('Number of Voxels')
    xlabel('MSE')
    title('MSE distribution spread b/w True,Pred')
    set(gca,'Xtick',0:0.02:0.15)
    
    subplot(1,3,2)
    hist(acc_vector,100)
    grid on
    ylabel('Number of Voxels')
    xlabel('ACC')
    title('ACC distribution spread b/w True,Pred')
    
    subplot(1,3,3)
    hist(csd_acc_vector,100)
    grid on
    ylabel('Number of Voxels')
    xlabel('ACC')
    title('CSD ACC distribution spread b/w True,Pred')

    figure
    subplot(1,3,1)
    hist(true_gfa_vector,100)
    grid on
    ylabel('Number of Voxels')
    xlabel('GFA')
    xlim([0.2 1])
    title('True GFA spread')
    
    subplot(1,3,2)
    hist(pred_gfa_vector,100)
    grid on
    ylabel('Number of Voxels')
    xlabel('GFA')
    %ylim([0 250])
    title('Predicted GFA spread')
    
    subplot(1,3,3)
    hist(diff_gfa_vector,100)
    grid on
    ylabel('Number of Voxels')
    xlabel('GFA')
    title('Diff in GFA spread (True-Pred)')
    
end