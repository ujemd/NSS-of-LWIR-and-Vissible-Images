# NSS-of-LWIR-and-Vissible-Images

Authors: Hernán Benítez and David Moreno
Version: 1.0
Contact: david.moreno@javerianacali.edu.co

## Synopsis

This is a demonstration of the work presented in Natural Scene Statistics of LWIR and Visible Images. Which proposes fused image quality metrics and presents a subjective human study for their construction and validation. Files included are: the Matlab implementation of a *completely blind* and an *opinion aware fused image quality analyzer*, the original raw opinion scores, Z-scores after subject rejection, and Differential Mean Opinion Scores (DMOS).

## Quality metrics for fused image quality assessment

Input: A test fused image loaded in an array.

Output: A quality score of the image. A higher value indicates lower quality.

### Completely Blind Fused Image Quality Analyzer

Usage:

1. Load the image: ``` fused_image = imread('fused_image1.bmp'); ```
2. Load a pristine MVG model: ``` load pristineModel.mat ```
3. Call the metricIQA function: ``` quality = metricIQA(fused_image,pristineModel); ```

Dependencies:
- Mat file (provided): pristineModel.mat
- MatalbPyrTools: http://www.cns.nyu.edu/lcv/software.php
- EmGm: http://www.mathworks.com/matlabcentral/fileexchange/26184-em-algorithm-for-gaussian-mixture-model--em-gmm-

### Opinion Aware Image Quality Analyzer

Usage:

1. Load the image: ``` fused_image = imread('fused_image1.bmp'); ```
2. Call the metricIQA function: ``` quality = metricSVM(fused_image); ```

Dependencies:
- Mat files (provided): SVMmodel.mat, dmos.mat, trainX.mat, logistic-function-param.mat
- MatalbPyrTools: http://www.cns.nyu.edu/lcv/software.php
- Libsvm: https://www.csie.ntu.edu.tw/~cjlin/libsvm/

## Subjective Study Files

- raw-opinion-scores.mat contains the raw opinion scores given by 27 subjects for 750 fused images over 5 sessions. The size of the opinion scores matrix is 27x150x5 (subjects x images per session x sessions).
- Z-scores.mat contains the Z-scores of the difference scores after subject rejection (five subjects were rejected). The size is 22x675 (subjects x distorted fused images).
- dmos.mat contains the differential mean opinion scores (DMOS) for 675 distorted fused images after subject rejection.
