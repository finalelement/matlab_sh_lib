function detect_groups_outliers
    load('outliers_indices_dl_csd.mat')
    orig_outlier_indices = csd_outliers;
    length_outliers = length(orig_outlier_indices);
    outlier_groups = [];
    for i=1:909:57267
        min_val = i;
        max_val = i+909;
        
        counter = 0;
        for j=1:length_outliers
            if (min_val <= orig_outlier_indices(j) && orig_outlier_indices(j) < max_val)
                counter = counter + 1;
            end
        end
        
        if (counter >=3)
            outlier_groups = [outlier_groups;min_val];
        end
    end
    
    outlier_groups

end