input1 = [-1.1250+0.6250i, -0.6856-1.0786i, -0.2286+0.0518i, -0.1426-0.1738i,  0.1250-0.1250i,  0.6064+0.1341i,  0.3018+0.4786i, -0.1841+0.5210i, -0.3750+0.3750i,  0.5089+1.1518i,  0.4786-0.3018i,  0.3194-0.2530i, -0.1250 + 0.1250i, -0.4296 + 0.2926i, -0.0518 - 0.2286i,  0.0073 - 0.5942i];
input2 = [-1.3750+0.8750i,  0.3276-0.2039i, -0.0884-0.7437i,  0.6804-0.4068i, -0.2500-0.7500i,  0.4890+0.1362i,  0.6187+0.3902i, -0.1344-0.4494i, -1.3750+0.1250i, -0.1508+0.0271i,  0.0884+0.4937i, -0.8572+0.2300i,  0.0000 + 0.7500i, -0.6658 + 0.0406i, -0.6187 - 0.1402i,  0.3112 + 0.6262i];
input3 = [-1.3750+0.1250i,  0.1560-0.7033i, -0.1250+0.7589i, -0.3474+0.4705i,  0.1250+0.1250i, -0.2517-0.2396i, -0.6553+0.8321i,  0.3870+0.7990i, -1.1250+0.8750i,  0.0207+0.2766i, -0.1250-1.0089i,  0.1706-0.3973i, -0.1250 - 0.1250i,  0.0749 + 0.1663i,  0.4053 - 0.5821i, -0.2102 - 0.3722i];
input4 = [-1.2500+0.1250i,  0.4724+0.3162i,  0.1768+0.0518i,  0.1603+1.0842i,  0.0000+0.1250i,  0.3352-0.3913i,  0.3536+0.1250i, -0.4119-0.0292i, -1.0000+0.8750i, -0.0456-0.7430i, -0.1768-0.3018i, -0.0871-1.0110i,  0.2500 - 0.1250i, -0.2620 + 0.3181i, -0.3536 + 0.1250i,  0.8386 + 0.4560i];


% input1 = [-0.6856-1.0786i, -1.1250+0.6250i,  -0.1426-0.1738i, -0.2286+0.0518i,    0.6064+0.1341i, 0.1250-0.1250i, 0.3018+0.4786i, -0.1841+0.5210i, -0.3750+0.3750i,  0.5089+1.1518i,  0.4786-0.3018i,  0.3194-0.2530i, -0.1250 + 0.1250i, -0.4296 + 0.2926i, -0.0518 - 0.2286i,  0.0073 - 0.5942i];
fft_1 = fft(input1);
fft_2 = fft(input2);
fft_3 = fft(input3);
fft_4 = fft(input4);


fft_x= 16*(0:1:(16-1))/16;

figure;
subplot(4,1,1)
plot(fft_x,abs(fft_1)) 
xlabel('f (Hz)')
ylabel('|P1(f)|')

subplot(4,1,2)
plot(fft_x,abs(fft_2)) 
xlabel('f (Hz)')
ylabel('|P1(f)|')

subplot(4,1,3)
plot(fft_x,abs(fft_3)) 
xlabel('f (Hz)')
ylabel('|P1(f)|')

subplot(4,1,4)
plot(fft_x,abs(fft_4)) 
xlabel('f (Hz)')
ylabel('|P1(f)|')








roundTargets = [100 1 -1 3 -3 -100];
demo_array1=[];
demo_array2=[];
demo_array3=[];
demo_array4=[];
for i=1:length(fft_1)
    temp_i=real(fft_1(i));
    temp_q=imag(fft_1(i));
    Rounded_i = interp1(roundTargets,roundTargets,temp_i,'nearest');
    Rounded_q = interp1(roundTargets,roundTargets,temp_q,'nearest');
    temp_vector1=[Rounded_i;Rounded_q];
    demo_array1=[demo_array1,temp_vector1];
end
for i=1:length(fft_2)
    temp_i=real(fft_2(i));
    temp_q=imag(fft_2(i));
    Rounded_i = interp1(roundTargets,roundTargets,temp_i,'nearest');
    Rounded_q = interp1(roundTargets,roundTargets,temp_q,'nearest');
    temp_vector2=[Rounded_i;Rounded_q];
    demo_array2=[demo_array2,temp_vector2];
end
for i=1:length(fft_3)
    temp_i=real(fft_3(i));
    temp_q=imag(fft_3(i));
    Rounded_i = interp1(roundTargets,roundTargets,temp_i,'nearest');
    Rounded_q = interp1(roundTargets,roundTargets,temp_q,'nearest');
    temp_vector3=[Rounded_i;Rounded_q];
    demo_array3=[demo_array3,temp_vector3];
end
for i=1:length(fft_4)
    temp_i=real(fft_4(i));
    temp_q=imag(fft_4(i));
    Rounded_i = interp1(roundTargets,roundTargets,temp_i,'nearest');
    Rounded_q = interp1(roundTargets,roundTargets,temp_q,'nearest');
    temp_vector4=[Rounded_i;Rounded_q];
    demo_array4=[demo_array4,temp_vector4];
end


data_str='';
for i=1:length(demo_array1)
    temp_vector=demo_array1(:,i);
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
output1 ='';
for i=1:8:length(data_str)-7
    temp_str=data_str(i:i+7);
    chrmtx = @(x) char(bin2dec(reshape(x(:).',[],8))); 
    Out = chrmtx(temp_str);
    output1= append(output1,Out);
end

data_str='';
for i=1:length(demo_array2)
    temp_vector=demo_array2(:,i);
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
output2 ='';
for i=1:8:length(data_str)-7
    temp_str=data_str(i:i+7);
    chrmtx = @(x) char(bin2dec(reshape(x(:).',[],8))); 
    Out = chrmtx(temp_str);
    output2= append(output2,Out);
end

data_str='';
for i=1:length(demo_array3)
    temp_vector=demo_array3(:,i);
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
output3 ='';
for i=1:8:length(data_str)-7
    temp_str=data_str(i:i+7);
    chrmtx = @(x) char(bin2dec(reshape(x(:).',[],8))); 
    Out = chrmtx(temp_str);
    output3= append(output3,Out);
end

data_str='';
for i=1:length(demo_array4)
    temp_vector=demo_array4(:,i);
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
output4 ='';
for i=1:8:length(data_str)-7
    temp_str=data_str(i:i+7);
    chrmtx = @(x) char(bin2dec(reshape(x(:).',[],8))); 
    Out = chrmtx(temp_str);
    output4= append(output4,Out);
end
