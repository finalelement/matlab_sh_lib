function plot_box_acc_gfa_diff_fixed_loss

    % Load CSD, ISMRM, NSDN for TS04

    % Load CSD
    csd_ts04_3ta = load_untouch_nii('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TA\csd_out_3ta.nii')
    csd_ts04_3tb = load_untouch_nii('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TB\csd_out_3tb.nii')
    
    csd_ts04_3ta = csd_ts04_3ta.img;
    dims = size(csd_ts04_3ta);
    csd_ts04_3ta = reshape(csd_ts04_3ta,[dims(1)*dims(2)*dims(3) 45]);
    
    csd_ts04_3tb = csd_ts04_3tb.img;
    dims = size(csd_ts04_3tb);
    csd_ts04_3tb = reshape(csd_ts04_3tb,[dims(1)*dims(2)*dims(3) 45]);
    
    % Load ISMRM
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Histo_final_no_outliers_exact_b6000_save_model\ISMRM_TS04_Test\result_scan_a.mat')
    ts4_ismrm_3ta = predicted;
    clear predicted
    
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Histo_final_no_outliers_exact_b6000_save_model\ISMRM_TS04_Test\result_scan_b.mat')
    ts4_ismrm_3tb = predicted;
    clear predicted
    
    % Load NSDN predictions
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_loss_fixed_final\TS04\result_NSDN_3ta.mat')
    ts4_nsdn_3ta = predicted;
    clear predicted
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_loss_fixed_final\TS04\result_NSDN_3tb.mat')
    ts4_nsdn_3tb = predicted;
    clear predicted
    
    % Load CSD, ISMRM, NSDN for TS01
    % Load CSD
    
    csd_ts01_3tb = load_untouch_nii('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS01\3TB\csd_out_3tb.nii')
    csd_ts01_austin = load_untouch_nii('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS01\Austin\csd_out_austin.nii')
    
    csd_ts01_3tb = csd_ts01_3tb.img;
    dims = size(csd_ts01_3tb);
    csd_ts01_3tb = reshape(csd_ts01_3tb,[dims(1)*dims(2)*dims(3) 45]);
    
    csd_ts01_austin = csd_ts01_austin.img;
    dims = size(csd_ts01_austin);
    csd_ts01_austin = reshape(csd_ts01_austin,[dims(1)*dims(2)*dims(3) 45]);
    
    
    % Load ISMRM
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Histo_final_no_outliers_exact_b6000_save_model\ISMRM_TS01_Test\result_scan_a.mat')
    ts1_ismrm_3tb = predicted;
    clear predicted
    
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Histo_final_no_outliers_exact_b6000_save_model\ISMRM_TS01_Test\result_scan_b.mat')
    ts1_ismrm_austin = predicted;
    clear predicted
    
    % Load NSDN
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_loss_fixed_final\TS01\result_NSDN_3tb.mat')
    ts1_nsdn_3tb = predicted;
    clear predicted
    load('D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\py_code\Null_space_CV_MICCAI_extended_loss_fixed_final\TS01\result_NSDN_austin.mat')
    ts1_nsdn_austin = predicted;
    clear predicted
    
    % Load the WM masks
    ts4_wm_mask_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\T1_WM\ts04_wm_mask.nii';
    ts4_wm_mask = load_untouch_nii(ts4_wm_mask_path);
    ts4_mask = ts4_wm_mask.img;
    
    ts1_wm_mask_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS01\T1_WM\ts01_wm_mask.nii';
    ts1_wm_mask = load_untouch_nii(ts1_wm_mask_path);
    ts1_mask = ts1_wm_mask.img;
    
    % NSDN slash out the pair predictions
    ts4_nsdn_3ta = ts4_nsdn_3ta(:,133:end);
    ts4_nsdn_3tb = ts4_nsdn_3tb(:,133:end);
    ts1_nsdn_3tb = ts1_nsdn_3tb(:,133:end);
    ts1_nsdn_austin = ts1_nsdn_austin(:,133:end);
    
    
    
    % ACC's of TS4 for CSD, ISMRM, NSDN
    [ts4_outlier_csd,ts4_csd_acc] = call_acc_vol_mask(csd_ts04_3ta ,csd_ts04_3tb,ts4_mask);
    [ts4_outlier_ismrm,ts4_ismrm_acc] = call_acc_vol_mask(ts4_ismrm_3ta, ts4_ismrm_3tb, ts4_mask);
    [ts4_outlier_nsdn,ts4_nsdn_acc] = call_acc_vol_mask(ts4_nsdn_3ta, ts4_nsdn_3tb, ts4_mask);
    
    % ACC's of TS1 for CSD, ISMRM, NSDN
    [ts1_outlier_csd,ts1_csd_acc] = call_acc_vol_mask(csd_ts01_3tb, csd_ts01_austin, ts1_mask);
    [ts1_outlier_ismrm,ts1_ismrm_acc] = call_acc_vol_mask(ts1_ismrm_3tb, ts1_ismrm_austin, ts1_mask);
    [ts1_outlier_nsdn,ts1_nsdn_acc] = call_acc_vol_mask(ts1_nsdn_3tb, ts1_nsdn_austin, ts1_mask);
    
    % Figure 1 
    % All right lets make some pretty box plots !
    
    figure(1)
    clf
    subplot(1,2,1)
    boxplot([ts4_csd_acc,ts4_ismrm_acc,ts4_nsdn_acc],'Notch','on','Labels',{'TS4_CSD','TS4_DN','TS4_NSDN'})
    grid on
    title('ACC 3TA and 3TB Subject 1')
    subplot(1,2,2)
    boxplot([ts1_csd_acc,ts1_ismrm_acc,ts1_nsdn_acc],'Notch','on','Labels',{'TS1_CSD','TS1_DN','TS1_NSDN'})
    title('ACC 3TB and Austin Subject 2')
    grid on
    hold on
    
    % Figure 2
    % Make a violin plot of these matrices
    figure(2)
    clf
    % Concatenate matrices in m by n fashion
    ts4_acc = [ts4_csd_acc,ts4_ismrm_acc,ts4_nsdn_acc];
    distributionPlot(ts4_acc,'colormap',gray)
    grid on
    
    % Figure 3
    % Make Transparent Histograms ! Screw violin plots and boxplots
    figure(3)
    clf
    [h1,p1] = hist(ts4_csd_acc,100);
    [h2,p2] = hist(ts4_ismrm_acc,100);
    [h3,p3] = hist(ts4_nsdn_acc,100);
    bar(p1,h1,'FaceColor','r','FaceAlpha',0.8,'EdgeColor','none')
    hold on
    bar(p2,h2,'FaceColor','b','FaceAlpha',0.6,'EdgeColor','none')
    bar(p3,h3,'FaceColor','g','FaceAlpha',0.4,'EdgeColor','none')
    grid on
    legend('CSD','DN','NSDN','Location','best')
    legend boxoff
    ylabel('No. of Voxels')
    xlabel('ACC')
    title('ACC Distribution')
    
    % Figure 4 
    figure(4)
    scatter(1:100,h1,'r','x')
    hold on
    scatter(1:100,h2,'g','o')
    scatter(1:100,h3,'b','*')
    grid on
   
    % Figure 5
    %line([med_csd,med_csd],[0,800],'color','red')
    ts4_csd_acc_median = nanmedian(ts4_csd_acc);
    ts4_ismrm_acc_median = nanmedian(ts4_ismrm_acc);
    ts4_nsdn_acc_median = nanmedian(ts4_nsdn_acc);
    figure(5)
    plot(h1,'r--','LineWidth',2)
    hold on
    plot(h2,'g-.','LineWidth',2)
    plot(h3,'b','LineWidth',2)
    legend('CSD','DN','NSDN','Location','best')
    grid on
    legend boxoff
    ylabel('No. of Voxels')
    xlabel('ACC')
    xticklabels(linspace(-1,1,11))
    %line([ts4_csd_acc_median,ts4_csd_acc_median],[0,800],'Color','red')
    %line([med_csd,med_csd],[0,800],'Color','green')
    %line([med_csd,med_csd],[0,800],'Color','blue')
    
    [h1,p1] = hist(ts1_csd_acc,100);
    [h2,p2] = hist(ts1_ismrm_acc,100);
    [h3,p3] = hist(ts1_nsdn_acc,100);
    
    figure(8)
    plot(h1,'r--','LineWidth',2)
    hold on
    plot(h2,'g-.','LineWidth',2)
    plot(h3,'b','LineWidth',2)
    legend('CSD','DN','NSDN','Location','best')
    grid on
    legend boxoff
    ylabel('No. of Voxels')
    xlabel('ACC')
    
    
    % Lets get the differences of the GFA
    %TS 04
    [ts4_csd_diff_gfa,~,~] = call_gfa_diff_vol_mask(csd_ts04_3ta ,csd_ts04_3tb, ts4_mask);
    [ts4_ismrm_diff_gfa,~,~] = call_gfa_diff_vol_mask(ts4_ismrm_3ta(:,1:45) ,ts4_ismrm_3tb(:,1:45), ts4_mask);
    [ts4_nsdn_diff_gfa,~,~] = call_gfa_diff_vol_mask(ts4_nsdn_3ta(:,1:45) ,ts4_nsdn_3tb(:,1:45), ts4_mask);
    
    % TS01
    [ts1_csd_diff_gfa,~,~] = call_gfa_diff_vol_mask(csd_ts01_3tb ,csd_ts01_austin, ts1_mask);
    [ts1_ismrm_diff_gfa,~,~] = call_gfa_diff_vol_mask(ts1_ismrm_3tb(:,1:45) ,ts1_ismrm_austin(:,1:45), ts1_mask);
    [ts1_nsdn_diff_gfa,~,~] = call_gfa_diff_vol_mask(ts1_nsdn_3tb(:,1:45) ,ts1_nsdn_austin(:,1:45), ts1_mask);
    
    figure(6)
    [h1,p1] = hist(ts4_csd_diff_gfa,100);
    [h2,p2] = hist(ts4_ismrm_diff_gfa,100);
    [h3,p3] = hist(ts4_nsdn_diff_gfa,100);
    bar(p1,h1,'FaceColor','r','FaceAlpha',0.8,'EdgeColor','none')
    hold on
    bar(p2,h2,'FaceColor','b','FaceAlpha',0.6,'EdgeColor','none')
    bar(p3,h3,'FaceColor','g','FaceAlpha',0.4,'EdgeColor','none')
    grid on
    legend('CSD','ISMRM','NSDN','Location','best')
    legend boxoff
    ylabel('No. of Voxels')
    xlabel('Diff GFA')
    title('Diff GFA Distribution')
    
    figure(7)
    plot(h1,'r--','LineWidth',2)
    hold on
    plot(h2,'g-.','LineWidth',2)
    plot(h3,'b','LineWidth',2)
    legend('CSD','DN','NSDN','Location','best')
    grid on
    legend boxoff
    ylabel('No. of Voxels')
    xlabel('Diff GFA')

end