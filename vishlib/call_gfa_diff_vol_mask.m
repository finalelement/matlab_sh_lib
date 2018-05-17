function [diff_gfa,gfa_v1,gfa_v2] = call_gfa_diff_vol_mask(vol_1,vol_2,wm_mask)

    dims = size(wm_mask);
    mask_vec = reshape(wm_mask,[dims(1)*dims(2)*dims(3) 1]);
    
    gfa_v1 = [];
    gfa_v2 = [];
    
    for i=1:(dims(1)*dims(2)*dims(3))
        if (mask_vec(i) == 1)
            vox_sh_3ta = vol_1(i,:);
            vox_sh_3tb = vol_2(i,:);
           
            % Calc the GFA's
            gfa_val_1 = calcGFA(vox_sh_3ta);
            gfa_val_2 = calcGFA(vox_sh_3tb);
            
            gfa_v1 = [gfa_v1;gfa_val_1];
            gfa_v2 = [gfa_v2;gfa_val_2];
            
        end
    end
    
    diff_gfa = gfa_v1 - gfa_v2;
           
end