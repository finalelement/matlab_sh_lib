function vis_randomized_new_data(voxel_number)
    
    close all;
    
    load('my_new_input.mat')
    load('my_new_output.mat')

    out_matrix = my_new_output;
    input_matrix = my_new_input;
    
    xform_RAS = eye(3);
    figure;
    plot_counter = 1;
    for i=1:5

        in_voxel_data = input_matrix(voxel_number,:);
        sh_raw_coeffs = reshape(in_voxel_data,[1 1 1 45]);
        dv = dwmri_visualizer(sh_raw_coeffs, ...
                      1, ...
                      1, ...
                      xform_RAS, ...
                      'sh_coefs', ...
                      {8,120,true});
        dv.plot_slice(1,'axial','slice',[],subplot(5,2,plot_counter));
        axis image;
        light('Position', [5, 5, 5], 'Style', 'infinite')
        plot_counter = plot_counter + 1;
        
        voxel_out = out_matrix(voxel_number,:);
        sh_raw_coeffs_out = reshape(voxel_out,[1 1 1 45]);
        dv_hist = dwmri_visualizer(sh_raw_coeffs_out, ...
                  1, ...
                  1, ...
                  xform_RAS, ...
                  'sh_coefs', ...
                  {8,120,true});
        dv_hist.plot_slice(1,'axial','slice',[],subplot(5,2,plot_counter));
        axis image;
        light('Position', [5, 5, 5], 'Style', 'infinite')
        title('Hist')
        plot_counter = plot_counter + 1;
        
        
        voxel_number = voxel_number + 20;
    end
        
end
       