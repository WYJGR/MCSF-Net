import glob

import cv2 as cv
import numpy as np


def UCIQE(nargin, loc):
    img_bgr = cv.imread(loc)
    img_bgr = cv.resize(img_bgr, (350, 350))  # Used to read image files
    img_lab = cv.cvtColor(img_bgr, cv.COLOR_BGR2LAB)  # Transform to Lab color space

    if nargin == 1:  # According to training result mentioned in the paper:
        coe_metric = [0.4680, 0.2745, 0.2576]  # Obtained coefficients are: c1=0.4680, c2=0.2745, c3=0.2576.
    img_lum = img_lab[..., 0] / 255
    img_a = img_lab[..., 1] / 255
    img_b = img_lab[..., 2] / 255

    img_chr = np.sqrt(np.square(img_a) + np.square(img_b))  # Chroma

    img_sat = img_chr / np.sqrt(np.square(img_chr) + np.square(img_lum))  # Saturation
    aver_sat = np.mean(img_sat)  # Average of saturation

    aver_chr = np.mean(img_chr)  # Average of Chroma

    var_chr = np.sqrt(np.mean(abs(1 - np.square(aver_chr / img_chr))))  # Variance of Chroma

    dtype = img_lum.dtype  # Determine the type of img_lum
    if dtype == 'uint8':
        nbins = 256
    else:
        nbins = 65536

    hist, bins = np.histogram(img_lum, nbins)  # Contrast of luminance
    cdf = np.cumsum(hist) / np.sum(hist)

    ilow = np.where(cdf > 0.0100)
    ihigh = np.where(cdf >= 0.9900)
    tol = [(ilow[0][0] - 1) / (nbins - 1), (ihigh[0][0] - 1) / (nbins - 1)]
    con_lum = tol[1] - tol[0]

    # get final quality value
    quality_val = coe_metric[0] * var_chr + coe_metric[1] * con_lum + coe_metric[2] * aver_sat
    return quality_val


# 获取UCIQE 越大越好
def get_UCIQE(res_dir):
    uciqes = []
    # 导入测试集
    images = glob.glob(res_dir + "*")
    # 遍历每个图像
    for img in images:
        score = UCIQE(1, img)
        uciqes.append(score)

    return np.mean(np.array(uciqes))

def get_One_UCIQE(imgPath):
    return UCIQE(1, imgPath)