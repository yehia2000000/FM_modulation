
[y,Fs]=audioread("eric.wav");
%sound(y,Fs)

% Use Matlab to read the attached audio file, which has a sampling frequency Fs=48 KHz. Find the spectrum of this signal (the signal in frequency domain). 
Freq_domain = fftshift(fft(y));
length(Freq_domain)
Freq = linspace(-Fs/2,Fs/2,length(Freq_domain));
Freq_domain_mag = abs (Freq_domain);
Freq_domain_angle = angle (Freq_domain);
plot(Freq , Freq_domain_mag);
%figure ; 
%plot(Freq , Freq_domain_angle);


% Using an ideal Filter, remove all frequencies greater than 4 KHz. 
Freq_domain([1:172000 (length(Freq_domain_mag)-172000):length(Freq_domain_mag)])=0 ;
Freq_domain_mag_filtered = abs (Freq_domain);
%figure ; 
%plot(Freq , Freq_domain_mag_filtered);

%3. Obtain the filtered signal in time domain, this is a band limited signal of BW=4KHz
y_filtered = real(ifft(ifftshift(Freq_domain)));
t = linspace (0,411248/48000,411248);
figure;
plot(t,y_filtered);

%4. sound the filtered audio signal (make sure that there is only a small error in the filtered signal) [sound] 
sound (y_filtered,Fs);

%3. Generate the NBFM signal. Use a carrier frequency of 100kHz and a sampling frequency of ?? =5??. Plot the resulting spectrum
T = linspace (0,411248/500000,411248);
A=10;
kf=0.1;
fc = 100000 ;
fs=5*fc;
NB_signal = A*cos(2*pi*fc.*T' + kf*cumsum(y_filtered));
yy_freqDomain = fftshift(fft(NB_signal));
Freq1 = linspace(-fs/2,fs/2,length(yy_freqDomain));
%figure;
%plot(Freq1,abs(yy_freqDomain));

%5. Demodulate the NBFM signal using a differentiator and an ED. For the differentiator, you can use the following command: diff. Assume no noise is introduced
DE_signal = diff(NB_signal);
envelope = abs(hilbert(DE_signal));
mean_signal = mean(envelope);
Finial_signal = envelope - mean_signal ;
pause(9);
sound(Finial_signal,Fs);








