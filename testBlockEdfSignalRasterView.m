function testBlockEdfSignalRasterView
%testBlockEdfSignalRasterView Test BlockEdfSignalRasterView
%   Functionality present in BlockEdfSignalRasterView is tested.
%
%
% Version: 0.1.28
% ---------------------------------------------
% Dennis A. Dean, II, Ph.D
%
% Program for Sleep and Cardiovascular Medicine
% Brigam and Women's Hospital
% Harvard Medical School
% 221 Longwood Ave
% Boston, MA  02149
%
% File created: October 23, 2012
% Last update:  April 25, 2014 
%    
% Copyright © [2014] The Brigham and Women's Hospital, Inc. THE BRIGHAM AND 
% WOMEN'S HOSPITAL, INC. AND ITS AGENTS RETAIN ALL RIGHTS TO THIS SOFTWARE 
% AND ARE MAKING THE SOFTWARE AVAILABLE ONLY FOR SCIENTIFIC RESEARCH 
% PURPOSES. THE SOFTWARE SHALL NOT BE USED FOR ANY OTHER PURPOSES, AND IS
% BEING MADE AVAILABLE WITHOUT WARRANTY OF ANY KIND, EXPRESSED OR IMPLIED, 
% INCLUDING BUT NOT LIMITED TO IMPLIED WARRANTIES OF MERCHANTABILITY AND 
% FITNESS FOR A PARTICULAR PURPOSE. THE BRIGHAM AND WOMEN'S HOSPITAL, INC. 
% AND ITS AGENTS SHALL NOT BE LIABLE FOR ANY CLAIMS, LIABILITIES, OR LOSSES 
% RELATING TO OR ARISING FROM ANY USE OF THIS SOFTWARE.
%

% Test Flags
%---------------------------------------- MESA Data
TEST_1  = 1; % Generate ECG figures
TEST_2  = 0; % Create EEG powerpoint
TEST_3  = 0; % Get and set options (pleth)
TEST_4  = 0; % Add fn ant title options to GenerateSignalRasterViewFigures call
TEST_5  = 0; % Add support for pasing in EDF structure
TEST_6  = 0; % Add support for overlaying annotations
TEST_7  = 0; % Specify which pages to print
TEST_8  = 0; % Turn off display of epoch numbers

%------------------------------------------------------------------- Test 1
if TEST_1 == 1
    % Test description
    test_id = 1;
    test_description = 'Generate EKG figures';
    fprintf('Test %.0f: %s\n', test_id, test_description);

    % Input file
    fn = '201434_deidentified.EDF';

    % Create signalViewEdfSignals
    srvObj = BlockEdfSignalRasterView(fn);

    % Set signals to view
    edf_signals_labels = srvObj.edf_signals_labels;
    srvObj.signalToView = {'ECG'};
    srvObj.signalDisplayGain = [-0.15];

    % Set parameters
    srvObj.setFigurePosition = 1;
    srvObj.figurePosition = [-1919, 1, 1920, 1004];

    % Create Figures
    srvObj = srvObj.GenerateSignalRasterViewFigures;
end
%------------------------------------------------------------------- Test 2
if TEST_2 == 1
    % Test description
    test_id = 2;
    test_description = 'Create EEG powerpoint';
    fprintf('Test %.0f: %s\n', test_id, test_description);

    % Input file
    fn = '201434_deidentified.EDF';

    % Create signalViewEdfSignals
    srvObj = BlockEdfSignalRasterView(fn);

    % Set signals to view
    edf_signals_labels = srvObj.edf_signals_labels;
    srvObj.signalToView = {'EEG'};
    srvObj.signalDisplayGain = [0.25];
    srvObj.PptBySignal = 1;

    % Set parameters
    srvObj.setFigurePosition = 1;
    srvObj.figurePosition = [-1919, 1, 1920, 1004];

    % Create Figures
    srvObj = srvObj.GenerateSignalRasterViewFigures;
end
%------------------------------------------------------------------- Test 3
if TEST_3 == 1
    % Test description
    test_id = 3;
    test_description = 'Get and set options (EEG)';
    fprintf('Test %.0f: %s\n', test_id, test_description);

    % Input file
    fn = '201434_deidentified.EDF';

    % Create signalViewEdfSignals
    srvObj = BlockEdfSignalRasterView(fn);
    opt =  srvObj.opt;
    
    % Set parameters
    opt.signalDisplayGain = .25;
    opt.xAxisScale = 10;                % 2.5 minute x axis
    opt.numSignalsPerPageIndex = 8;     % 12 segments per page
    opt.setFigurePosition = 1;         
    opt.figurePosition = [-1919, 1, 1920, 1004];
    opt.PptBySignal = 0;

    % Create Figures
    signalLabelCell = {'EEG'};
    srvObj = BlockEdfSignalRasterView(fn, signalLabelCell, opt);
    srvObj.subjectID = '201434'; 
    srvObj = srvObj.GenerateSignalRasterViewFigures;
end
%------------------------------------------------------------------- Test 4
if TEST_4 == 1
    % Test description
    test_id = 4;
    test_description = 'Add fn an title options to GenerateSignalRasterViewFigures call';
    fprintf('Test %.0f: %s\n', test_id, test_description);
    
    % Input file
    fn = '201434_deidentified.EDF';

    % Create Option Structure
    srvObj = BlockEdfSignalRasterView(fn);
    opt =  srvObj.opt;  

    % Set parameters
    opt.signalDisplayGain = .1;
    opt.xAxisScale = 10;                % 2.5 minute x axis
    opt.numSignalsPerPageIndex = 10;     % 12 segments per page
    opt.setFigurePosition = 1;         
    opt.figurePosition = [-1919, 1, 1920, 1004];
    opt.PptBySignal = 1;  

    % Create figures and create power point
    signLabelCell = {'EMG' };
    srvObj = BlockEdfSignalRasterView(fn, signLabelCell, opt);
    
    % Override default PPT name
    pptFn = '201434.EMG_1.ppt';
    titleStr = 'MESA Subject 201434 - Plethysmography';
    srvObj = srvObj.GenerateSignalRasterViewFigures(pptFn);
    pptFn2 = '201434.EMG_2.ppt';
    srvObj = srvObj.GenerateSignalRasterViewFigures(pptFn2, titleStr);
end
%------------------------------------------------------------------- Test 5
if TEST_5 == 1
    % Test Description
    test_id = 5;
    test_description = 'Add support for pasing in EDF structure';
    fprintf('Test %.0f: %s\n', test_id, test_description);
    
    % Get EEG signal
    fn = '201434_deidentified.EDF';
    signalLabelCell = {'EEG'};
    [header, signalHeader, signalCell] = blockEdfLoad(fn, signalLabelCell);
    edfStruct.header = header;
    edfStruct.signalHeader = signalHeader;
    edfStruct.signalCell = signalCell;       
 
    % Get BlockEdfSignalRasterView option structure
    srvObj = BlockEdfSignalRasterView;
    opt =  srvObj.opt;
    
    % Set parameters
    opt.signalDisplayGain = .4;
    opt.xAxisScale = 10;                % 2.5 minute x axis
    opt.numSignalsPerPageIndex = 10;     % 12 segments per page
    opt.setFigurePosition = 1;         
    opt.figurePosition = [-1919, 1, 1920, 1004];
    opt.PptBySignal = 1;    

    % Get, show and select signal labels
    srvObj = BlockEdfSignalRasterView(edfStruct, signalLabelCell, opt);
    
    % Create Power Point
    pptFn = '201434.EEG.EDF_Struct_Test.ppt';
    titleStr = 'Subject 201434 - EEG';    
    svObj = srvObj.GenerateSignalRasterViewFigures(pptFn, titleStr);
end
%------------------------------------------------------------------- Test 6
if TEST_6 == 1
    % Test description
    test_id = 6;
    test_description = 'Add support for overlaying annotations';
    fprintf('Test %.0f: %s\n', test_id, test_description);
    
    % Get arousal times
    fnXML = '201434_deidentified.EDF.XML';
    lcaObj = loadCompumedicsAnnotationsClass(fnXML);
    lcaObj = lcaObj.loadXmlStruct;
    lcaObj = lcaObj.loadFile;

    % Get detailed event information
    EventList = lcaObj.EventList;
    EventTypes = lcaObj.EventTypes;
    EventStart = lcaObj.EventStart;  
    
    % Get arousal start time
    arousalLabel = EventTypes{1};
    arousalStart = ...
        lcaObj.GetEventTimes(arousalLabel, EventList, EventStart);
    
    % Get BlockEdfSignalRasterView option structure
    srvObj = BlockEdfSignalRasterView;
    opt =  srvObj.opt;
    
    % Set option parameters
    opt.signalDisplayGain = .4;
    opt.xAxisScale = 10;                 % 2.5 minute x axis
    opt.numSignalsPerPageIndex = 10;     % 12 segments per page
    opt.setFigurePosition = 1;         
    opt.figurePosition = [-1919, 1, 1920, 1004];
    opt.PptBySignal = 1;    
    
    % Create EEG RasterPlot with Arousal Annotations
    fn = '201434_deidentified.EDF';
    signalLabelCell = {'EEG'};
    srvObj = BlockEdfSignalRasterView(fn, signalLabelCell, opt,arousalStart);
    
    % Annotation parameters
    srvObj.AnnoteMarkerSize = 10;
    srvObj.AnnoteMarker = 'v';
    srvObj.AnnoteColor = [1 0 0];
    srvObj.AnnoteLabel = 'Arousal';
    
    % Create Power Point
    pptFn = '201434.EEG1.Arousals.ppt';
    titleStr = 'Subject 201434 - EEG w Arousals';    
    svObj = srvObj.GenerateSignalRasterViewFigures(pptFn, titleStr);
    
end

%------------------------------------------------------------------- Test 7
if TEST_7 == 1
    % Test description
    test_id = 7;
    test_description = 'Specify which pages to print';
    fprintf('Test %.0f: %s\n', test_id, test_description);
    
    % Get arousal times
    fnXML = '201434_deidentified.EDF.XML';
    lcaObj = loadCompumedicsAnnotationsClass(fnXML);
    lcaObj = lcaObj.loadXmlStruct;
    lcaObj = lcaObj.loadFile;

    % Get detailed event information
    EventList = lcaObj.EventList;
    EventTypes = lcaObj.EventTypes;
    EventStart = lcaObj.EventStart;  
    
    % Get arousal start time
    arousalLabel = EventTypes{1};
    arousalStart = ...
        lcaObj.GetEventTimes(arousalLabel, EventList, EventStart);
    
    % Get BlockEdfSignalRasterView option structure
    srvObj = BlockEdfSignalRasterView;
    opt =  srvObj.opt;
    
    % Set option parameters
    opt.signalDisplayGain = .4;
    opt.xAxisScale = 10;                 % 2.5 minute x axis
    opt.numSignalsPerPageIndex = 10;     % 12 segments per page
    opt.setFigurePosition = 1;         
    opt.figurePosition = [-1919, 1, 1920, 1004];
    opt.PptBySignal = 1;    
    
    % Create EEG RasterPlot with Arousal Annotations
    fn = '201434_deidentified.EDF';
    signalLabelCell = {'EEG'};
    srvObj = BlockEdfSignalRasterView(fn, signalLabelCell, opt,arousalStart);
    
    % Annotation parameters
    srvObj.AnnoteMarkerSize = 10;
    srvObj.AnnoteMarker = 'v';
    srvObj.AnnoteColor = [1 0 0];
    srvObj.AnnoteLabel = 'Arousal';
    
    % Create Power Point
    generatePages = [3:4];
    pptFn = '201434.EEG1.Arousals.pp3_4.ppt';
    titleStr = 'Subject 201434 - EEG w Arousals';    
    svObj = ...
        srvObj.GenerateSignalRasterViewFigures(pptFn, titleStr, generatePages);
end
%------------------------------------------------------------------- Test 8
if TEST_8 == 1
    % Test description
    test_id = 8;
    test_description = 'Turn off epoch numbers';
    fprintf('Test %.0f: %s\n', test_id, test_description);
    
    % Get arousal times
    fnXML = '201434_deidentified.EDF.XML';
    lcaObj = loadCompumedicsAnnotationsClass(fnXML);
    lcaObj = lcaObj.loadXmlStruct;
    lcaObj = lcaObj.loadFile;

    % Get detailed event information
    EventList = lcaObj.EventList;
    EventTypes = lcaObj.EventTypes;
    EventStart = lcaObj.EventStart;  
    
    % Get arousal start time
    arousalLabel = EventTypes{1};
    arousalStart = ...
        lcaObj.GetEventTimes(arousalLabel, EventList, EventStart);
    
    % Get BlockEdfSignalRasterView option structure
    srvObj = BlockEdfSignalRasterView;
    opt =  srvObj.opt;
    
    % Set option parameters
    opt.signalDisplayGain = .4;
    opt.xAxisScale = 10;                 % 2.5 minute x axis
    opt.numSignalsPerPageIndex = 10;     % 12 segments per page
    opt.setFigurePosition = 1;         
    opt.figurePosition = [-1919, 1, 1920, 1004];
    opt.PptBySignal = 1;    
    
    % Create EEG RasterPlot with Arousal Annotations
    fn = '201434_deidentified.EDF';
    signalLabelCell = {'EEG'};
    srvObj = BlockEdfSignalRasterView(fn, signalLabelCell, opt,arousalStart);
    
    % Annotation parameters
    srvObj.AnnoteMarkerSize = 10;
    srvObj.AnnoteMarker = 'v';
    srvObj.AnnoteColor = [1 0 0];
    srvObj.AnnoteLabel = 'Arousal';
    srvObj.AddEpochNumbers = 0;
    
    % Create Power Point
    pptFn = '201434.EEG1.Arousals.no_epoch_num.ppt';
    titleStr = 'MESA Subject 201434 - EEG1 w Arousals';    
    svObj = ...
        srvObj.GenerateSignalRasterViewFigures(pptFn, titleStr);
end
end

