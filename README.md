# Introduction
This is a Matlab function running forward-backward stepwise regression algorithm to identify nonlinear model in the form of

 Y = \Sum {k_i * P_i(x)}
 
to fit given N data points. 

- Y (Nx1) is the model output.
- x (Nxm) are m dimentional model inputs. 
- P_i(x) is the ith regressor as any form of function of x.
- k_i is the coefficient of the ith regressor.

By providing a candidate pool (dictionary) of P_i(x), this algorithm can select P_i(x) from the pool and identify the coefficients.

# Platform
Matlab 2019a

Matlab signal processing toolbox




