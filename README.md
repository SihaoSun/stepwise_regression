# Introduction
This is a Matlab function running stepwise regression algorithm to fit given N data points. The identified model is in the form of

 Y = \Sum {k_i * P_i(x)}
 
- Y (Nx1) is the model output.
- x (Nxm) are m dimentional model inputs. 
- P_i(x) is the ith regressor as an arbitrary function of x.
- k_i is the coefficient of the ith regressor.

By providing a dictionary of candidate P_i(x), this algorithm selects P_i(x) from the dictionary and identify their coefficients for minimizing least square data fitting errors. 

If you use this code in an academic context, please cite

```
@article{GrayboxSun2018,
author = {Sun, Sihao and de Visser, Coen C. and Chu, Qiping},
doi = {10.2514/1.C035135},
issn = {0021-8669},
journal = {Journal of Aircraft},
month = {mar},
number = {2},
pages = {645--661},
title = {{Quadrotor Gray-Box Model Identification from High-Speed Flight Data}},
url = {https://arc.aiaa.org/doi/10.2514/1.C035135},
volume = {56},
year = {2019}
}
```

# Tested Platform
Matlab 2019a

Matlab signal processing toolbox

# Example
We provide the example dataset (example_data.mat) containing output y, and two inputs x1, x2.

where 
 - y = 0.4 + sin(t) + 0.5 * cos(3 * t) + 0.2 * cos(3 * t) * sin(1.5 * t-pi/3) + white_noise;
 - x1 = sin(t) + white_noise
 - x2 = cos(3 * t) + white_noise

Obviously, the best model to fit dataset is
y = 0.4 + 1.0 * x1 + 0.5 * x2 + 0.2 * x1 * x2.

In main.m function, the user can provide arbitrary candidate regressors P_i(x) in matrix X. If the candidate pool contains regressor x1, x2 and x1 * x2, the algorithm will select them into the model and identify their coefficients. 



