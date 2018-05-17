function [diff_gfa,gfa_vol_v1,gfa_vol_v2] = call_gfa_diff_vol_mask_3d(vol_1,vol_2,wm_mask)

    dims = size(wm_mask);
    %mask_vec = reshape(wm_mask,[dims(1)*dims(2)*dims(3) 1]);
    gfa_v1 = reshape(vol_1,[dims(1) dims(2) dims(3) 45]);
    gfa_v2 = reshape(vol_2,[dims(1) dims(2) dims(3) 45]);
    
    gfa_vol_v1 = zeros(dims);
    gfa_vol_v2 = zeros(dims);
    
    for i=1:dims(1)
        for j=1:dims(2)
            for k=1:dims(3)
                if (wm_mask(i,j,k) == 1)
                    vox_sh_3ta = gfa_v1(i,j,k,:);
                    vox_sh_3tb = gfa_v2(i,j,k,:);

                    gfa_val_1 = calcGFA(vox_sh_3ta);
                    gfa_val_2 = calcGFA(vox_sh_3tb);

                    gfa_vol_v1(i,j,k) = gfa_val_1;
                    gfa_vol_v2(i,j,k) = gfa_val_2;
                end
            end
        end
    end
    
    diff_gfa = gfa_vol_v1 - gfa_vol_v2;
           
end