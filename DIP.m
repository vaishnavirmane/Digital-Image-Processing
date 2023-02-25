%% Read and Show Input Image
image = imread('Image 2.jpg'); % Read Image
figure, imshow(image); % Show Image
title('INPUT IMAGE WITH NOISE');
image = rgb2gray(image); % Convert to Gray Scale
bwimage = ~imbinarize(image); % Convert to Binary Image
figure, imshow(bwimage);

%% Remove all object containing fewer than 50 pixels
final = bwareaopen(bwimage,50);
figure, imshow(final);
title('INPUT IMAGE WITHOUT NOISE');
pause(1)
[Gx,thresh,Gy,Gxy] = edge(bwimage,'canny')
figure
subplot (2,2,1);
imshow(Gx,[]); title ('Vertical detect');
subplot(2,2,2);
imshow(Gy,[]); title ('horizontal detect');
subplot(2,2,3);
imshow(Gxy,[]); title ('edge detection');
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
Gxy8 = uint8(round(Gxy*255));
se=strel('disk',12);
dIM1 = imdilate(Gxy8,se);
figure;
imshow(dIM1);
title ('dilated image');
se2=strel('disk',17);
Iop = imopen(dIM1,se2);
figure;
imshow(Iop);
title ('opened image');
final2 = immultiply(Iop ,Ib);
figure;
imshow(final);
title( 'final');
L = bwlabel(final2); % Label Connected Components
%% Measure Properties of Image Regions
propied = regionprops(L,'BoundingBox');
figure, imshow(final2);
hold on

%% Plot Bounding Box
for n=1:size(propied,1)
rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off
pause (1)

%% Text Extraction
text = ocr(final2);
recognizedText = text.Text;
myicon = text_image;
h=msgbox(sprintf('TEXT EXTRACTED IS :: %s',recognizedText),'TEXTEXTRACTED','custom',myicon);
disp(recognizedText);
