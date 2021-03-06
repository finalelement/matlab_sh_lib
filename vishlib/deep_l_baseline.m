function deep_l_baseline

    load('invivo_ts4_3ta.mat')
    ts4_3ta = predicted;
    clear predicted
    load('invivo_ts4_3tb.mat')
    ts4_3tb = predicted;
    clear predicted
    
    % Load the WM mask and reshape it into a vector
    wm_mask_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\TS04\T1_WM\ts04_wm_mask.nii';
    wm_mask = load_untouch_nii(wm_mask_path);
    mask = wm_mask.img;
    dims = size(mask);
    
    mask_vec = reshape(mask,[dims(1)*dims(2)*dims(3) 1]);
    
    acc_vec = [];
    for i=1:442368
        if (mask_vec(i) == 1)
           vox_sh_3ta = ts4_3ta(i,:);
           vox_sh_3tb = ts4_3tb(i,:);
           
           % Calc ACC
           acc_val = angularCorrCoeff(vox_sh_3ta,vox_sh_3tb);
           acc_vec = [acc_vec;acc_val];
        
        end
    end

    acc_vec(isnan(acc_vec)) = 0;
    figure
    hist(acc_vec,100)
    display(median(acc_vec))

end