## FRQFRECHET wrapper
MATLAB wrapper around FRQFRECHET (FORTRAN 77)  
Created by Daan Hanssens  
Contact Daan.Hanssens@UGent.be  

This repository contains the wrapper code associated with frqfrechet.exe (Niels B. Christensen);  
**Tølbøll R.J. and Christensen N.B., 2007, The sensitivity functions of frequencydomain magnetic dipole-dipole systems. Geophysics 72, F45–F56.**  

### Code
MATLAB wrapper around frqfrechet.exe (Niels B. Christensen); .exe file has to be in the same library. Run the script FRQ_Frechet_start.m

### FRQFRECHET 
(c) Niels B. Christensen  
The program FRQFRECHET calculates the 3D, 2D, and 1D sensitivity functions (Frechét kernels) for a homogeneous halfspace for frequency domain magnetic dipole-dipole configurations in the quasistatic approximation. Source and receiver can be located at any height on or above the surface of the earth and they can be oriented in the x-, y- and z directions independent of each other. The sensitivity functions can be for the magnetic field or for its derivative: the induction. The coordinate system referred to is a right-hand system with z vertical down and x along the profile parallel to the Tx-Rx direction. The 3D Fréchet kernels are calculated in planes perpendicular to the x-, y- or z- direction. The 2D Fréchet kernel is calculated for a plane perpendicular to the y-direction. If 2D sensitivity is calculated, the 1D Fréchet kernels can also be computed, both 1D in the vertical direction (integrated over x and y) and in the lateral direction (integrated over y and z). Also the total integral over the whole halfspace is computed.  
**Please note that I do not distribute the frqfrechet.exe program. Please contact Niels B. Christensen (nbs@geo.au.dk)**
