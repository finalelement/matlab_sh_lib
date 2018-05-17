function visualize_mr_hist_true_pred_csd(voxel_nums)
    
    %clear all;
    load('testing_csd.mat')
    load('test_set_input_b6000.mat')
    load('test_set_output_10th_order_final.mat')
    load('result_b6000_testing_10th_order.mat')
    
    
    xform_RAS = eye(3);
    %figure
    plot_counter = 1;
    for i=1:length(voxel_nums)
        
        % Plot the signal 
        mri_voxel = test_set_input_b6000(voxel_nums(i),:);
        sh_raw_coeffs = reshape(mri_voxel,[1 1 1 45]);
        dv_mri = dwmri_visualizer(sh_raw_coeffs, ...
                                  1, ...
                                  1, ...
                                  xform_RAS, ...
                                  'sh_coefs', ...
                                  {8,120,true});
        %dv_mri.plot_slice(1,'axial','slice',[],subplot(3,4,plot_counter));
        dv_mri.plot_slice(1,'axial','slice')
        axis image;
        light('Position', [5, 5, 5], 'Style', 'infinite')
        %title('MRI Signal')
        plot_counter = plot_counter + 1;
        
        % Plot the Histology FOD
        hist_voxel = test_set_output_10th_order_final(voxel_nums(i),:);
        sh_hist_coeffs = reshape(hist_voxel,[1 1 1 66]);
        dv_hist = dwmri_visualizer(sh_hist_coeffs, ...
                                  1, ...
                                  1, ...
                                  xform_RAS, ...
                                  'sh_coefs', ...
                                  {10,120,true});
        %dv_hist.plot_slice(1,'axial','slice',[],subplot(3,4,plot_counter));
        dv_hist.plot_slice(1,'axial','slice')
        axis image;
        light('Position', [5, 5, 5], 'Style', 'infinite')
        %title('Histology FOD')
        plot_counter = plot_counter + 1;
        
        % Plot CSD Prediction
        csd_voxel = test_csd(voxel_nums(i),:);
        sh_csd_coeffs = reshape(csd_voxel,[1 1 1 45]);
        dv_csd = dwmri_visualizer(sh_csd_coeffs, ...
                                  1, ...
                                  1, ...
                                  xform_RAS, ...
                                  'sh_coefs', ...
                                  {8,120,true});
        %dv_csd.plot_slice(1,'axial','slice',[],subplot(3,4,plot_counter));
        dv_csd.plot_slice(1,'axial','slice')
        axis image;
        light('Position', [5, 5, 5], 'Style', 'infinite')
        %title('CSD')
        plot_counter = plot_counter + 1;
        
        % DNN Prediction
        dnn_voxel = out_pred(voxel_nums(i),:);
        sh_dnn_coeffs = reshape(dnn_voxel,[1 1 1 66]);
        dv_dnn = dwmri_visualizer(sh_dnn_coeffs, ...
                                  1, ...
                                  1, ...
                                  xform_RAS, ...
                                  'sh_coefs', ...
                                  {10,120,true});
        %dv_dnn.plot_slice(1,'axial','slice',[],subplot(3,4,plot_counter));
        dv_dnn.plot_slice(1,'axial','slice')
        axis image;
        light('Position', [5, 5, 5], 'Style', 'infinite')
        %title('DNN')
        plot_counter = plot_counter + 1;
         
    end

end