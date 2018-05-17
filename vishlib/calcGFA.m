function [ GFA ] = calcGFA( plm_v )
%calcGFA computes generalized anisotropy of spherical profile represented
%by spherical harmonics expansion
%
% References:
%   1. Cohen-Adad, J. Detection of Multkple pathways in the spinal cord
%   using q-ball imaging. 2008.
%   2. Tuch, D. Q-Ball Imaging. 2004.
%   Detailed explanation goes here

GFA = sqrt(1 - (plm_v(1)^2)/sum(abs(plm_v).^2));


end