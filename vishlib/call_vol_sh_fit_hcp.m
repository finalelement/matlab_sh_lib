function call_vol_sh_fit_hcp

    
    %HCP Original data paths
    global_mask = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\HCP\b3000_Extracted\hcp_wm_mask.nii';
    nifti_path = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\HCP\b3000_Extracted\retest_b3000.nii';
    nifti_bvec = 'D:\Users\Vishwesh\PycharmProjects\Deep_Null_Space\Final_data\HCP\b3000_Extracted\retest_b3000.bvec';
    
    nifti = load_untouch_nii(nifti_path);
    nifti_bvec = dlmread(nifti_bvec);
    %nifti_bvec = nifti_bvec(:,2:97);
    mask = load_untouch_nii(global_mask);
    mask = mask.img;
    
    %{ 
    Removing it specifically for TS04 because it is normalized data.
    
    % Divide the entire gradient volume by b0 before passing it in
    my_img = nifti.img(:,:,:,2:97);
    b0 = nifti.img(:,:,:,1);
    dims = size(my_img);
    
    norm_nifti = zeros(dims(1),dims(2),dims(3),96);
    
    for i=1:96
        temp = my_img(:,:,:,i)./b0;
        norm_nifti(:,:,:,i) = temp;
    end
    %}
    
    
    sh_vol = sh_vol_fit(nifti.img,nifti_bvec,mask);
    sh_vol(isnan(sh_vol)) = 0;
    
    dims = size(nifti.img);
    nifti.hdr.dime.dim = [4 dims(1) dims(2) dims(3) 45 1 1 1];
    nifti.img = sh_vol;
    
    save_untouch_nii(nifti,'original_sh_8th_order.nii')
    
end