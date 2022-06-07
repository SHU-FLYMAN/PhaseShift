function pha = m_calc_wrapped_phase(Is, N, idx)
sin_sum = 0.;
cos_sum = 0.;

for k = 1: N
    Ik = Is{idx, k};
    sin_sum = sin_sum + Ik * sin(2 * (k - 1) * pi / N);
    cos_sum = cos_sum + Ik * cos(2 * (k - 1) * pi / N);
end
pha = -atan2(sin_sum, cos_sum);
end