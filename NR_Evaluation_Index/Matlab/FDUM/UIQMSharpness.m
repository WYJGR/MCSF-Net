function Value=UIQMSharpness(I)
    [UIQM_norm, colrfulness, sharpness, contrast] = UIQM(I);
    Value=sharpness;
end