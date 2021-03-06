
%input video path
vid = 'planes';

%specify format
format = '.mp4';
mat = '.mat';
path = strcat(vid,format);
dest = strcat(vid,mat);

%read video
video = VideoReader(path);



nBins = 256;
frame_len = video.NumberOfFrames;
frames(frame_len) = 0;

framesX(frame_len) = 0;

for i = 1 : frame_len
    framesX(i) = i/video.FrameRate;
end

for i = 1 : frame_len 
    
    frame = read(video, i);
    rHist = imhist(frame(:,:,1), nBins);
    gHist = imhist(frame(:,:,2), nBins);
    bHist = imhist(frame(:,:,3), nBins);
    
    
    if i ~= frame_len
    frame1 = read(video, i+1);
    r1Hist = imhist(frame1(:,:,1), nBins);
    g1Hist = imhist(frame1(:,:,2), nBins);
    b1Hist = imhist(frame1(:,:,3), nBins);
    end
    
    frames(i)= sum(abs(rHist-r1Hist) + abs(gHist-g1Hist) + abs(bHist-b1Hist))/3;
    
    
    clc;
    X = ['Process: ', num2str(int64((i/frame_len)*100)), '%'];
    disp(X)
end


save(dest,'frames');

plot(framesX,frames)
xlabel('Duration(s)')
ylabel('RGB Rate of Change')


