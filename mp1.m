clear
clc
close all

fileID = fopen('input_signal.txt','r');
formatSpec = '%f';
input = fscanf(fileID,formatSpec)';
inputf = fft(input);
preamble = readmatrix('Preamble.txt');

Fs = 100;                
dt = 1/Fs;                
StopTime = 30;           
t = (0:dt:StopTime-dt)';    
Fc = 20;                   
down_conv_cos = cos(2*pi*Fc*t)';
down_conv_sin = sin(2*pi*Fc*t)';

% Downconvert
down_conv_I = down_conv_cos .* input;
down_conv_Q = down_conv_sin .* input;
figure;
subplot(2,1,1)
plot(down_conv_I)
subplot(2,1,2)
plot(down_conv_Q)

% Low pass filter
fft_I = fft(down_conv_I);
fft_Q = fft(down_conv_Q);
fft_x= 100*(0:1:(3000-1))/3000;

figure;
subplot(2,1,1)
plot(fft_x,abs(fft_I/max(fft_I))) 
title('Single-Sided Amplitude Spectrum of fftI')
xlabel('f (Hz)')
ylabel('|P1(f)|')
subplot(2,1,2)
plot(fft_x,abs(fft_Q/max(fft_Q))) 
title('Single-Sided Amplitude Spectrum of fftQ')
xlabel('f (Hz)')
ylabel('|P1(f)|')

for i = 1:length(fft_x)
    if fft_x(i) > 5.1
        fft_I(i) = 0;
        fft_Q(i) = 0;
    end
end

con_I = real(ifft(fft_I)*4);
con_Q = real(ifft(fft_Q)*4);
% % cutoff = 5.1/100;
% order=16;
% h=fir1(order, cutoff);
% figure;
% subplot(2,1,1)
% con_I = conv(down_conv_I,h)*2;
% plot(con_I)
% subplot(2,1,2)
% con_Q = conv(down_conv_Q,h)*2;
% plot(con_Q)
% con_I=lowpass(down_conv_I,5.1,100)*2;
% con_Q=lowpass(down_conv_Q,5.1,100)*2;
% figure;
% plot(con_I)
% figure;
% plot(con_It)

%Downsample
sample_I = [];
sample_Q = [];
comparray = [];
for i = 1:length(con_I)
    if rem(i,10) == 1
        sample_I = [sample_I,con_I(i)];
        sample_Q = [sample_Q,con_Q(i)];
    end
end

for i = 1:length(sample_I)
    temp=complex(sample_I(i), sample_Q(i));
    comparray=[comparray,temp];
end

% Correlate
figure;
preamble = preamble';
coor_array=[];
zeroarray = zeros(1,length(preamble));
comparray_e=[comparray, zeroarray];
for i =1:length(comparray)
    temp_coor = comparray_e(i:i+length(preamble)-1) .* preamble;  
    temp_coor = sum(temp_coor);
    coor_array = [coor_array, temp_coor];
end
plot(abs(coor_array))

% Demodulate
real_coor_array = real(coor_array);
max_in_coor_array_index = find(real_coor_array==max(real_coor_array));
demo_array=[];
data = comparray(max_in_coor_array_index+50:length(comparray));
roundTargets = [100 1 -1 3 -3 -100];
for i=1:length(data)
    temp_i=real(data(i));
    temp_q=imag(data(i));
    Rounded_i = interp1(roundTargets,roundTargets,temp_i,'nearest');
    Rounded_q = interp1(roundTargets,roundTargets,temp_q,'nearest');
    temp_vector=[Rounded_i;Rounded_q];
    demo_array=[demo_array,temp_vector];
end

data_str='';
for i=1:length(demo_array)
    temp_vector=demo_array(:,i);
    if (temp_vector(1) == 1) && (temp_vector(2) == 1)
        data_str=append(data_str,'0101');
    end
    if (temp_vector(1) == 1) && (temp_vector(2) == 3)
        data_str=append(data_str,'0001');
    end
    if (temp_vector(1) == 3) && (temp_vector(2) == 1)
        data_str=append(data_str,'0100');
    end
    if (temp_vector(1) == 3) && (temp_vector(2) == 3)
        data_str=append(data_str,'0000');
    end
    if (temp_vector(1) == 1) && (temp_vector(2) == -1)
        data_str=append(data_str,'1101');
    end
    if (temp_vector(1) == 1) && (temp_vector(2) == -3)
        data_str=append(data_str,'1001');
    end
    if (temp_vector(1) == 3) && (temp_vector(2) == -1)
        data_str=append(data_str,'1100');
    end
    if (temp_vector(1) == 3) && (temp_vector(2) == -3)
        data_str=append(data_str,'1000');
    end
    if (temp_vector(1) == -1) && (temp_vector(2) == 1)
        data_str=append(data_str,'0111');
    end
    if (temp_vector(1) == -1) && (temp_vector(2) == 3)
        data_str=append(data_str,'0011');
    end
    if (temp_vector(1) == -3) && (temp_vector(2) == 1)
        data_str=append(data_str,'0110');
    end
    if (temp_vector(1) == -3) && (temp_vector(2) == 3)
        data_str=append(data_str,'0010');
    end
    if (temp_vector(1) == -1) && (temp_vector(2) == -1)
        data_str=append(data_str,'1111');
    end
    if (temp_vector(1) == -1) && (temp_vector(2) == -3)
        data_str=append(data_str,'1011');
    end
    if (temp_vector(1) == -3) && (temp_vector(2) == -1)
        data_str=append(data_str,'1110');
    end
    if (temp_vector(1) == -3) && (temp_vector(2) == -3)
        data_str=append(data_str,'1010');
    end
end
output ='';
for i=1:8:length(data_str)-7
    temp_str=data_str(i:i+7);
    chrmtx = @(x) char(bin2dec(reshape(x(:).',[],8))); 
    Out = chrmtx(temp_str);
    output= append(output,Out);
end

