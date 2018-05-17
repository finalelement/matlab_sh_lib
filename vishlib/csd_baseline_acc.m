function csd_baseline_acc

    % Load both 3TA and 3TB CSD files and the mask
    %csd_3ta_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TA\csd_out_3ta.nii';
    %csd_3tb_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\3TB\csd_out_3tb.nii';
    %wm_mask_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\T1_WM\ts04_wm_mask.nii';
    
    % Load both 3TA and 3TB CSD files and the mask
    csd_3ta_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS01\3TB\csd_out_3tb.nii';
    csd_3tb_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS01\Austin\csd_out_austin.nii';
    wm_mask_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS01\T1_WM\ts01_wm_mask.nii';
    
    % Load the nifti's
    csd_3ta = load_untouch_nii(csd_3ta_path);
    csd_3tb = load_untouch_nii(csd_3tb_path);
    wm_mask = load_untouch_nii(wm_mask_path);
    
    acc_vec = [];
    
    dims = size(wm_mask.img);
    
    for x=1:dims(1)
        for y=1:dims(2)
            for z=1:dims(3)
                
                if (wm_mask.img(x,y,z) == 1)
                    vox_3ta = squeeze(csd_3ta.img(x,y,z,:));
                    vox_3tb = squeeze(csd_3tb.img(x,y,z,:));
                    
                    % zero padding to be on the same plane
                    vox_3ta(46:66) = 0;
                    vox_3tb(46:66) = 0;
                    
                    acc_val = angularCorrCoeff(vox_3ta,vox_3tb);
                    
                    acc_vec = [acc_vec;acc_val];
                    
                        
                end
                
                
            end
        end
    end
    
    acc_vec(isnan(acc_vec)) = 0;
    figure
    hist(acc_vec,100)
    display(median(acc_vec))
    title('CSD ACC')
    
end