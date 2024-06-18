% SEAWATER Library 
% Version 2.0.1   22-Apr-1998
%
%                  ******************************* 
%                  *      SEAWATER Library       * 
%                  *                             * 
%                  *       Version 2.0.1         * 
%                  *      (for Matlab 5.x)       * 
%                  *                             * 
%                  *                             *
%                  *     Phillip P. Morgan       * 
%                  *           CSIRO             * 
%                  *                             *
%                  * Phil.Morgan@marine.csiro.au *
%                  ******************************* 
%
% LIST OF ROUTINES:
%
%     sw_new     What's new in this version of seawater.
%
%     sw_adtg    Adiabatic temperature gradient 
%     sw_alpha   Thermal expansion coefficient (alpha) 
%     sw_aonb    Calculate alpha/beta (a on b) 
%     sw_beta    Saline contraction coefficient (beta) 
%     sw_bfrq    Brunt-Vaisala Frequency Squared (N^2)
%     sw_copy    Copyright and Licence file
%     sw_cp      Heat Capacity (Cp) of Sea Water 
%     sw_dens    Density of sea water 
%     sw_dens0   Denisty of sea water at atmospheric pressure 
%     sw_dist    Distance between two lat, lon coordinates
%     sw_dpth    Depth from pressure 
%     sw_f       Coriolis factor "f" 
%     sw_fp      Freezing Point of sea water 
%     sw_g       Gravitational acceleration 
%     sw_gpan    Geopotential anomaly  
%     sw_gvel    Geostrophic velocity 
%     sw_info    Information on the SEAWATER library. 
%     sw_pden    Potential Density 
%     sw_pres    Pressure from depth 
%     sw_ptmp    Potential temperature 
%     sw_sals    Salinity of sea water 
%     sw_salt    Salinity from cndr, T, P 
%     sw_satar   Solubility (saturation) of Ar in seawater
%     sw_satn2   Solubility (saturation) of N2 in seawater
%     sw_sato2   Solubility (saturation) of O2 in seawater
%     sw_svan    Specific volume anomaly 
%     sw_svel    Sound velocity of sea water 
%     sw_smow    Denisty of standard mean ocean water (pure water) 
%     sw_temp    Temperature from potential temperature 
%     sw_test    Run test suite on library
%     sw_ver     Version number of SEAWATER library
%
% LOW LEVEL ROUTINES CALLED BY ABOVE: (also available for you to use)
%
%     sw_c3515   Conductivity at (35,15,0) 
%     sw_cndr    Conductivity ratio   R = C(S,T,P)/C(35,15,0) 
%     sw_salds   Differiential dS/d(sqrt(Rt)) at constant T. 
%     sw_salrp   Conductivity ratio   Rp(S,T,P) = C(S,T,P)/C(S,T,0) 
%     sw_salrt   Conductivity ratio   rt(T)     = C(35,T,0)/C(35,15,0) 
%     sw_seck    Secant bulk modulus (K) of sea water 
%=======================================================================

% Contents.m $Revision: 1.6 $  $Date: 1998/04/22 02:12:17 $
