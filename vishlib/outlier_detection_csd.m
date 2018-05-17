function outlier_detection_csd
    load('original_voxels_in_out_csd.mat')
    
    acc_vector = [];
    
    for i=1:567
       
       % Extract CSD Sh coeffs 
       csd_sh_row = csd_rows(i,1:45);
       % Zero padding
       csd_sh_row(46:66) = 0;
       
       % Extract Histo Sh coeffs
       histo_row = output_rows(i,1:66);
       
       temp_acc = angularCorrCoeff(csd_sh_row,histo_row);
       acc_vector = [acc_vector;temp_acc];
        
    end

    figure(1)
    subplot(1,2,1)
    hist(acc_vector,100);
    title('ACC using CSD and Histology no rotations')
    xlabel('ACC')
    ylabel('No. of Voxels')
    grid on
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    load('out_matrix.mat')
    load('CSDmatrix.mat')
    
    full_acc_vector = [];
    
    for j=1:56267
        csd_sh_row = CSDmatrix(j,1:45);
        csd_sh_row(46:66) = 0;
        
        histo_row = out_matrix(j,:);
        
        temp_acc = angularCorrCoeff(csd_sh_row,histo_row);
        full_acc_vector = [full_acc_vector;temp_acc];
    end

    subplot(1,2,2)
    hist(full_acc_vector,100);
    title('ACC using CSD and Histology w Rotations')
    xlabel('ACC')
    ylabel('No. of Voxels')
    grid on
end