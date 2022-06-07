function pha12 = m_calc_absolute_phase(pha1, pha2)
mask1 = pha1 > pha2;
pha12 = (pha1 - pha2) .* mask1 + (2 * pi - (pha2 - pha1)) .* (1 - mask1);
end