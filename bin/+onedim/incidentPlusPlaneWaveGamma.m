function [V] = incidentPlusPlaneWaveGamma(mesh,hs,k0,k0z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% incidentGammaPlaneWave -- HALFSPACE VERSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creates an excitation vector corresponding to a plane wave going in the
% +z direction with longitudinal wavenumber k0z -- HALFSPACE VERSION
%
% inputs
%   mesh        [struct]        generated by onedim.generateMesh
%   hs          [struct]     halfspace structure
%   k0          [float]     free space wavenumber
%   k0z         [float]      longitudinal wavenumber
%
% outputs
%   V           [N x 1 double]  incident field vector
%
% example: 
%
% kurt schab -- kschab@scu.edu
% scu 
% 2021
eta=376.73;
N = mesh.N;
dz = mesh.dz;
z = mesh.z;
kx = sqrt(k0^2 - k0z^2);

% halfspace information
eh = hs.er;
h = hs.h;
kh = k0*sqrt(eh);
kzh = sqrt(kh^2-kx^2);
ct = k0z/k0;
cth = kzh/(k0*sqrt(eh));
etah = eta/sqrt(eh);

% halfspace reflection coefficient
gh = (etah/cth - eta/ct)/(etah/cth + eta/ct);

V = zeros(N,1);
for n = 1:N
    V(n) = dz*onedim.sinc(k0z*dz/(2*pi))*exp(1j*k0z*z(n))*gh*exp(-1j*k0z*2*h);
end

end
