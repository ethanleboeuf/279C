% function to format the current simulink diagram such that it is suitable for

% inclusion in latex reports

% inputs - model (required), filename (optional - defaults to model name)


% John Welford 19/04/2011

% altered 03/06/11 to not rotate the images and to correct the bounding box

% details in the output file


function saveSimulink(model,varargin)


if nargin==2

    fileName = [varargin{1} '.eps'];

else

    fileName = [model '.eps'];

end


%% remove folder separating slashes and spaces

folderSeps = findstr('/',fileName);

spaces = findstr(' ',fileName);

fileName([folderSeps spaces]) = '_';


%% find model size ratio (not a very neat way of doing this!)

% currently prints as a jpeg and then reads back in to find ratio

set_param(model,'PaperOrientation','Portrait'); % assumes most models are roughly landscape

tempFile = 'tempModel.jpeg';

set_param(model,'PaperPositionMode','auto'); % ensure that this is auto to prevent crashing

eval(['print(''-s' model ''',''-djpeg'',''' tempFile ''');']);

tempImage = imread(tempFile);

modelRatio = size(tempImage,2)/size(tempImage,1); % width/height

delete(tempFile); clear tempImage tempFile;


%% setup printing options

set_param(model,'PaperOrientation','Portrait'); % assumes most models are roughly landscape

paperSize = get_param(model,'PaperSize'); % find actual model size

set_param(model,'PaperPositionMode','manual'); % can mess with printing to other formats if not changed back to auto!

paperRatio = paperSize(1)/paperSize(2);

if paperRatio>modelRatio % height limited

    height = 0.99*paperSize(2);

    width = modelRatio/height;

    heightLimited = 1;

else % width limited

    width = 0.99*paperSize(1);

    height = width/modelRatio;

    heightLimited = 0;    

end

set_param(model,'PaperPosition',[0 0 width height]);


%% print to eps

eval(['print(''-s' model ''',''-deps'',''-r300'',''' fileName ''');']);

set_param(model,'PaperPositionMode','auto');


%% modify eps file to correct bounding box size

fid = fopen(fileName);

epsFileText = fscanf(fid,'%c',Inf);

fclose(fid);

% find correct line

bbLine = strfind(epsFileText,'%%BoundingBox:');

% assume that the spacing along the line does not vary

leftBB = str2num(epsFileText(bbLine+14:bbLine+19));

bottomBB = str2num(epsFileText(bbLine+20:bbLine+25));

widthBB = str2num(epsFileText(bbLine+26:bbLine+31));

heightBB = str2num(epsFileText(bbLine+32:bbLine+37));

% correct bounding box ratio

if heightLimited

    widthBBstr = num2str(modelRatio/heightBB,'%6.0f');

    epsFileText(bbLine+32-length(widthBBstr):bbLine+31) = widthBBstr;

else % width limited

    heightBBstr = num2str(widthBB/modelRatio,'%6.0f');

    epsFileText(bbLine+38-length(heightBBstr):bbLine+37) = heightBBstr;

end

% rewrite eps file

fid = fopen(fileName,'w');

fprintf(fid,'%c',epsFileText);

fclose(fid);