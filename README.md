BlockEdfSignalRasterView
========================

Create raster plots from signals stored in an EDF file

## Overview:
Function creates a raster plot from signals stored in an EDF file. The x axis of the raster plot represents time and the y axis presents seqential time segments. The X axis duration and number of segments to display on the y axis options are predefined to values most likely to be used in sleep and circadian research. Gridlines corresponding to 30 second sleep epochs are automatically displayed. The function can be used to create MATLAB figures and can be used to create power point summaries. 


See test file and souce code comments for additional information

## Function prototypes:

    obj = BlockEdfSignalRasterView(fn|edfStruct, signalLabelCell)
    obj = BlockEdfSignalRasterView(fn|edfStruct, signalLabelCell, opt)
    obj = BlockEdfSignalRasterView(fn|edfStruct, signalLabelCell, opt, anote)
    
   
## Generate Figures/PPT
    srvObj = srvObj.GenerateSignalRasterViewFigures;
    
    
## Acknowledgements: 
[saveppt2](http://www.mathworks.com/matlabcentral/fileexchange/19322-saveppt2) is used to create MS PowerPoint files.
