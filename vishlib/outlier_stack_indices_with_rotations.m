function outlier_stack_indices_with_rotations

    outlier_groups = [5455 27271 28180 30907 31816 36361];
    output_indices = [];
    for i = 1:length(outlier_groups)
        temp = outlier_groups(i):(outlier_groups(i)+908);
        output_indices = [output_indices,temp];
    end

end