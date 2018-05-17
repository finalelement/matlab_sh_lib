function [outlier_mask,acc_vec] = call_acc_vol_mask(vol_1,vol_2,wm_mask)

    dims = size(wm_mask);
    mask_vec = reshape(wm_mask,[dims(1)*dims(2)*dims(3) 1]);
    
    %Binary mask for analysis
    outlier_mask = zeros(size(mask_vec));
    
    acc_vec = [];
    low_acc_vec = zeros(size(mask_vec));
    
    for i=1:(dims(1)*dims(2)*dims(3))
        if (mask_vec(i) == 1)
           vox_sh_3ta = vol_1(i,:);
           vox_sh_3tb = vol_2(i,:);
           
           % Calc ACC
           acc_val = angularCorrCoeff(vox_sh_3ta,vox_sh_3tb);
           acc_vec = [acc_vec;acc_val];
           
           if (isnan(acc_val)==1)
              outlier_mask(i,1) = 1; 
           end
           
           if (acc_val<=0.6)
               low_acc_vec(i,1) = 1;
           end
        
        end
    end
    
    outlier_mask = reshape(outlier_mask,[dims(1) dims(2) dims(3)]);
    %acc_vec(isnan(acc_vec)) = 0;
    
end