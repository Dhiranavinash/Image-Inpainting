clc;
clear;

A = imread('IPMV_TEST10.bmp');
[r, c, k]=size(A);
Z=rgb2gray(A);

N = imnoise(Z, 'salt & pepper', 0.01); 
%N = imnoise(Z, 'gaussian'); 

T=input("Enter the threshold value: ");

for i = 2:r-1
    for j = 2:c-1
        if (N(i,j) <= T || N(i,j) >= 255-T)
            o=8;

            if(N(i+1,j)<= T || N(i+1,j) >= 255-T)
                o=o-1;
                A=0;
            else
                A =N(i+1,j);
            end

            if(N(i-1,j)<= T || N(i-1,j) >= 255-T)
                o=o-1;
                B=0;
            else
                B= N(i-1,j);
            end

            if(N(i+1,j+1)<= T || N(i+1,j+1) >= 255-T)
                o=o-1;
                E=0;
            else
                E= N(i+1,j+1);
            end

            if(N(i+1,j-1)<= T || N(i+1,j-1) >= 255-T)
                o=o-1;
                F=0;
            else
                F= N(i+1,j-1);
            end

            if(N(i-1,j+1)<= T || N(i-1,j+1) >= 255-T)
                o=o-1;
                G=0;
            else 
                G= N(i-1,j+1);
            end

            if(N(i,j+1)<= T || N(i,j+1) >= 255-T)
                o=o-1;
                D=0;
            else
                D= N(i,j+1);
            end

            if(N(i,j-1)<= T || N(i,j-1) >= 255-T)
                o=o-1;
                C=0;
            else
                C= N(i,j-1);
            end

            if(N(i-1,j-1)<= T || N(i-1,j-1) >= 255-T)
                o=o-1;
                H=0;
            else
                H= N(i-1,j-1);
            end

            if (o>=4)
              X(i,j)=A/o + B/o + C/o + D/o + E/o + F/o + G/o + H/o;
            else
                X(i,j) = N(i,j);
            end

        else
            X(i,j) = N(i,j);
        end
    end
end

Y=X;
for i = 3:r-2
    for j = 3:c-2
        if (X(i,j) <= T )
            o=8;
            if(X(i+1,j) >= 255-T)
                o=o-1;
            end

            if( X(i-1,j) >= 255-T)
                o=o-1;
            end

            if(X(i+1,j+1) >= 255-T)
                o=o-1;
            end

            if(X(i+1,j-1) >= 255-T)
                o=o-1;
            end

            if(X(i-1,j+1) >= 255-T)
                o=o-1;
            end

            if(X(i,j+1) >= 255-T)
                o=o-1;
            end

            if(X(i,j-1) >= 255-T)
                o=o-1;
            end

            if(X(i-1,j-1) >= 255-T)
                o=o-1;
            end
            if (o<=3)
                Y(i,j)= 255-T;
            end
        end

        if (X(i,j) >= 255-T )
            m=8;
            if(X(i+1,j) <= T)
                m=m-1;
            end

            if( X(i-1,j)  <= T)
                m=m-1;
            end

            if(X(i+1,j+1)  <= T)
                m=m-1;
            end

            if(X(i+1,j-1) <= T)
                m=m-1;
            end

            if(X(i-1,j+1)  <= T)
                m=m-1;
            end

            if(X(i,j+1)  <= T)
                m=m-1;
            end

            if(X(i,j-1)  <= T)
                m=m-1;
            end

            if(X(i-1,j-1)  <= T)
                m=m-1;
            end

            if (m<=3)
              Y(i,j)= T;
            end
        end
    end
end

subplot(1, 4, 1);
imshow(N);
title('Noisy Image');

subplot(1, 4, 2);
imshow(Y);
title('Restored Image');


L = medfilt2( N , [3 3] );
subplot(1, 4, 3);
imshow(L);
title('Median Filter');

Q = imboxfilt(N,[3 3]);
subplot(1, 4, 4);
imshow(Q);
title('Mean Filter');