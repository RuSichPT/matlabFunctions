function mas_out = add_AWGN(mas_in, nse_sigma)

   N = length(mas_in);
   mas_out = mas_in + 0.707 * nse_sigma * (randn(N,1) + 1i * randn(N,1));

end

