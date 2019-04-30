v= VideoReader('vib2.mp4');
frames=v.NumberOfFrames;
a=linspace(0,0,8805);
b=linspace(1,8805,8805);
count=0;t=0;
  


for j= 1:frames
    img=read(v,j);
    x=0; y=0; num=0;
    % Thershold and finding the centroid
    for row =1:640
        for col = 1:960
            if (img(row,col,1)>76 && img(row,col,2)<60&& img(row,col,3)<75)
                img(row,col,1)=255;
                img(row,col,2)=255;
                img(row,col,3)=255;
                
               x=x+row;
               y=y+col;
               num=num+1;
            end
        end
    end
    % Centroid Location
    x=x/num;
    y=y/num;
  %store amplitude
    a(1,j)=x-221.38;
  %determinattion of oscillation count   
if (t<=0&& x-221>=0||t>=0&&x-221<=0)
    count=count+0.5;
    t=x-221;
end
   

    % make centroid color to black
    for row=1:639
        for col=1:959
            if(row<x+2 && row>x-2 && col<y+2 && col>y-2)
                img(row,col,1)=0;
                img(row,col,2)=0;
                img(row,col,3)=0;
            end
        end
    end
    %mean position
    img(221,:,1)=0;
    img(221,:,2)=0;
    img(221,:,3)=0;
    %adding texts to video
  text_str=cell(6,1);
values=[x-221.38 666 count];
    text_str{1}=['Amplitude:' num2str(values(1),'%0.2f')];
    text_str{2}=['Mean Co-Ordinates are x= 221 y= 483'];
    text_str{3}=['Oscillation Count=' num2str(values(3),'%0.2f')];
    text_str{4}=['Maximum Amplitude=14.79'];
    text_str{5}=['mean position'];
    text_str{6}=['Made by Rajan kumar singh'];
position=[23 34; 600 600 ; 5 600;1 100;1 221;300 600];
box_color={'red','green','magenta','blue','cyan','yellow'};
img=insertText(img,position,text_str,'fontSize',18,'BoxColor', box_color,'BoxOpacity',0.5,'TextColor','white');
title('dgg')
imshow(img)
end
