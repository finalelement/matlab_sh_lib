%%%%%%%% How to visualize a slice 

xform_RAS = eye(3);
    dv_single = dwmri_visualizer(
    % Pass the entire 4D volume below
    sh_vol, ...
    % The background this should be a 3D volume  
    ones(96,96,48), ...
    % This is a mask that can be passed in.    
    ones(96,96,48), ...
    % Generally use eye(3), otherwise consult Justin
    xform_RAS, ...
    % Define spherical coeffs or other peaks, or diffusion glyphs    
    'sh_coefs', ...
    % Define the order and the sampling points, the 'true' is for min-max normalization    
    {8,60,true});
                      
    dv_single.plot_slice(24,'axial','slice');
    axis image;
    light('Position', [5, 5, 5], 'Style', 'infinite')
    title('Mid Slice voxel')