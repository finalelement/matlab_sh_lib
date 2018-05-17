function visualize_mr_hist_voxels_with_rotations(voxel_number)

    close all
    %load the data
    load('input_matrix.mat')
    load('out_matrix.mat')

    xform_RAS = eye(3);
    figure;
    plot_counter = 1;
    for i=1:5
        a = 1;
        b = 45;
        for j=1:5
            
            if(j==5)
                voxel_out = out_matrix(voxel_number,:);
                sh_raw_coeffs_out = reshape(voxel_out,[1 1 1 66]);
                dv_hist = dwmri_visualizer(sh_raw_coeffs_out, ...
                          1, ...
                          1, ...
                          xform_RAS, ...
                          'sh_coefs', ...
                          {10,120,true});
                dv_hist.plot_slice(1,'axial','slice',[],subplot(5,5,plot_counter));
                axis image;
                light('Position', [5, 5, 5], 'Style', 'infinite')
                title('Hist')
                plot_counter = plot_counter + 1;
            end
            
            if(j~=5)
                in_voxel_data = input_matrix(voxel_number,a:b);
                sh_raw_coeffs = reshape(in_voxel_data,[1 1 1 45]);
                dv = dwmri_visualizer(sh_raw_coeffs, ...
                              1, ...
                              1, ...
                              xform_RAS, ...
                              'sh_coefs', ...
                              {8,120,true});
                dv.plot_slice(1,'axial','slice',[],subplot(5,5,plot_counter));
                axis image;
                light('Position', [5, 5, 5], 'Style', 'infinite')

                if(j==1)
                    title('b3000')
                end
                if(j==2)
                    title('b6000')
                end
                if(j==3)
                    title('b9000')
                end    
                if(j==4)
                    title('b12000')
                end

                plot_counter = plot_counter + 1;
                a = a+45;
                b = b+45;
            end
        end
        voxel_number = voxel_number + 1;
    end
        
end