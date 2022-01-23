classdef USER_INTERFACE_APP < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        Button                  matlab.ui.control.Button
        EditField_15            matlab.ui.control.NumericEditField
        RBCLabel_6              matlab.ui.control.Label
        EditField_14            matlab.ui.control.NumericEditField
        WBCLabel_6              matlab.ui.control.Label
        EditField_13            matlab.ui.control.NumericEditField
        TOTALBLOODCELLSLabel_3  matlab.ui.control.Label
        EditField_12            matlab.ui.control.NumericEditField
        RBCLabel_5              matlab.ui.control.Label
        EditField_11            matlab.ui.control.NumericEditField
        WBCLabel_5              matlab.ui.control.Label
        EditField_10            matlab.ui.control.NumericEditField
        RBCLabel_4              matlab.ui.control.Label
        EditField_9             matlab.ui.control.NumericEditField
        WBCLabel_4              matlab.ui.control.Label
        EditField_8             matlab.ui.control.NumericEditField
        TOTALBLOODCELLSLabel_2  matlab.ui.control.Label
        EditField_7             matlab.ui.control.NumericEditField
        RBCLabel_3              matlab.ui.control.Label
        EditField_6             matlab.ui.control.NumericEditField
        WBCLabel_3              matlab.ui.control.Label
        YCbCrRESULTLabel        matlab.ui.control.Label
        CMYKRESULTLabel         matlab.ui.control.Label
        EditField_5             matlab.ui.control.NumericEditField
        EditField_4             matlab.ui.control.NumericEditField
        EditField_3             matlab.ui.control.NumericEditField
        EditField_2             matlab.ui.control.NumericEditField
        EditField               matlab.ui.control.NumericEditField
        RBCLabel_2              matlab.ui.control.Label
        RBCLabel                matlab.ui.control.Label
        WBCLabel_2              matlab.ui.control.Label
        TOTALBLOODCELLSLabel    matlab.ui.control.Label
        WBCLabel                matlab.ui.control.Label
        RGBRESULTLabel          matlab.ui.control.Label
        LOADBLOODSMEARButton    matlab.ui.control.Button
        UIAxes_10               matlab.ui.control.UIAxes
        UIAxes_9                matlab.ui.control.UIAxes
        UIAxes_8                matlab.ui.control.UIAxes
        UIAxes_5                matlab.ui.control.UIAxes
        UIAxes_2                matlab.ui.control.UIAxes
        UIAxes                  matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LOADBLOODSMEARButton
        function LOADBLOODSMEARButtonPushed(app, event)
            [file,path] = uigetfile({'*.jpg'; '*.png'}, 'Select An Image');
            if isequal(file,0)
               disp('User selected Cancel');
            else
               selectedfile = fullfile(path,file);
               %%Reading in the image
               myImage = imread(selectedfile);
   
             
   
   
           end
        end

        % Callback function
        function ButtonPushed(app, event)
        global vid;

% capture image
%inputimage = getframe(handles.rgb1);
       inputimage = getsnapshot(vid);

% Stop the video aquisition.
        stop(vid);
% Flush all the image data stored in the memory buffer.
       flushdata(vid);
       cla;

        set(handles.captureImg,'Visible','off');
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 756 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'RGB')
            app.UIAxes.XTick = [];
            app.UIAxes.YTick = [];
            app.UIAxes.Position = [33 281 213 149];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.UIFigure);
            title(app.UIAxes_2, 'CMYK')
            app.UIAxes_2.XTick = [];
            app.UIAxes_2.YTick = [];
            app.UIAxes_2.Position = [33 135 213 147];

            % Create UIAxes_5
            app.UIAxes_5 = uiaxes(app.UIFigure);
            title(app.UIAxes_5, 'YCbCr')
            app.UIAxes_5.XTick = [];
            app.UIAxes_5.YTick = [];
            app.UIAxes_5.YTickLabel = '';
            app.UIAxes_5.Position = [33 1 213 150];

            % Create UIAxes_8
            app.UIAxes_8 = uiaxes(app.UIFigure);
            title(app.UIAxes_8, 'RGB')
            app.UIAxes_8.XTick = [];
            app.UIAxes_8.YTick = [];
            app.UIAxes_8.Position = [285 281 208 148];

            % Create UIAxes_9
            app.UIAxes_9 = uiaxes(app.UIFigure);
            title(app.UIAxes_9, 'CMYK')
            app.UIAxes_9.XTick = [];
            app.UIAxes_9.YTick = [];
            app.UIAxes_9.Position = [285 135 209 147];

            % Create UIAxes_10
            app.UIAxes_10 = uiaxes(app.UIFigure);
            title(app.UIAxes_10, 'YCbCr')
            app.UIAxes_10.XTick = [];
            app.UIAxes_10.YTick = [];
            app.UIAxes_10.YTickLabel = '';
            app.UIAxes_10.Position = [283 6 220 141];

            % Create LOADBLOODSMEARButton
            app.LOADBLOODSMEARButton = uibutton(app.UIFigure, 'push');
            app.LOADBLOODSMEARButton.ButtonPushedFcn = createCallbackFcn(app, @LOADBLOODSMEARButtonPushed, true);
            app.LOADBLOODSMEARButton.FontWeight = 'bold';
            app.LOADBLOODSMEARButton.FontAngle = 'italic';
            app.LOADBLOODSMEARButton.Position = [171 428 242 29];
            app.LOADBLOODSMEARButton.Text = 'LOAD BLOOD SMEAR';

            % Create RGBRESULTLabel
            app.RGBRESULTLabel = uilabel(app.UIFigure);
            app.RGBRESULTLabel.FontSize = 14;
            app.RGBRESULTLabel.FontWeight = 'bold';
            app.RGBRESULTLabel.Position = [492 428 108 28];
            app.RGBRESULTLabel.Text = 'RGB RESULT';

            % Create WBCLabel
            app.WBCLabel = uilabel(app.UIFigure);
            app.WBCLabel.Position = [503 402 49 20];
            app.WBCLabel.Text = 'WBC';

            % Create TOTALBLOODCELLSLabel
            app.TOTALBLOODCELLSLabel = uilabel(app.UIFigure);
            app.TOTALBLOODCELLSLabel.FontSize = 8;
            app.TOTALBLOODCELLSLabel.FontWeight = 'bold';
            app.TOTALBLOODCELLSLabel.Position = [501 368 90 25];
            app.TOTALBLOODCELLSLabel.Text = 'TOTAL BLOOD CELLS';

            % Create WBCLabel_2
            app.WBCLabel_2 = uilabel(app.UIFigure);
            app.WBCLabel_2.FontName = 'Arial';
            app.WBCLabel_2.FontWeight = 'bold';
            app.WBCLabel_2.Position = [505 340 49 21];
            app.WBCLabel_2.Text = 'WBC %';

            % Create RBCLabel
            app.RBCLabel = uilabel(app.UIFigure);
            app.RBCLabel.Position = [581 402 49 21];
            app.RBCLabel.Text = 'RBC';

            % Create RBCLabel_2
            app.RBCLabel_2 = uilabel(app.UIFigure);
            app.RBCLabel_2.FontName = 'Arial';
            app.RBCLabel_2.FontWeight = 'bold';
            app.RBCLabel_2.Position = [502 305 49 23];
            app.RBCLabel_2.Text = 'RBC %';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'numeric');
            app.EditField.Position = [537 404 39 17];

            % Create EditField_2
            app.EditField_2 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_2.Position = [620 404 42 19];

            % Create EditField_3
            app.EditField_3 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_3.Position = [599 369 50 23];

            % Create EditField_4
            app.EditField_4 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_4.Position = [561 339 50 22];

            % Create EditField_5
            app.EditField_5 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_5.Position = [561 305 50 22];

            % Create CMYKRESULTLabel
            app.CMYKRESULTLabel = uilabel(app.UIFigure);
            app.CMYKRESULTLabel.FontSize = 14;
            app.CMYKRESULTLabel.FontWeight = 'bold';
            app.CMYKRESULTLabel.Position = [493 263 108 28];
            app.CMYKRESULTLabel.Text = 'CMYK RESULT';

            % Create YCbCrRESULTLabel
            app.YCbCrRESULTLabel = uilabel(app.UIFigure);
            app.YCbCrRESULTLabel.FontSize = 14;
            app.YCbCrRESULTLabel.FontWeight = 'bold';
            app.YCbCrRESULTLabel.Position = [501 108 108 28];
            app.YCbCrRESULTLabel.Text = 'YCbCr RESULT';

            % Create WBCLabel_3
            app.WBCLabel_3 = uilabel(app.UIFigure);
            app.WBCLabel_3.Position = [501 233 49 17];
            app.WBCLabel_3.Text = 'WBC';

            % Create EditField_6
            app.EditField_6 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_6.Position = [537 233 39 17];

            % Create RBCLabel_3
            app.RBCLabel_3 = uilabel(app.UIFigure);
            app.RBCLabel_3.Position = [599 231 49 21];
            app.RBCLabel_3.Text = 'RBC';

            % Create EditField_7
            app.EditField_7 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_7.Position = [637 232 42 19];

            % Create TOTALBLOODCELLSLabel_2
            app.TOTALBLOODCELLSLabel_2 = uilabel(app.UIFigure);
            app.TOTALBLOODCELLSLabel_2.FontSize = 8;
            app.TOTALBLOODCELLSLabel_2.FontWeight = 'bold';
            app.TOTALBLOODCELLSLabel_2.Position = [501 200 90 25];
            app.TOTALBLOODCELLSLabel_2.Text = 'TOTAL BLOOD CELLS';

            % Create EditField_8
            app.EditField_8 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_8.Position = [600 202 50 23];

            % Create WBCLabel_4
            app.WBCLabel_4 = uilabel(app.UIFigure);
            app.WBCLabel_4.FontName = 'Arial';
            app.WBCLabel_4.FontWeight = 'bold';
            app.WBCLabel_4.Position = [505 176 49 21];
            app.WBCLabel_4.Text = 'WBC %';

            % Create EditField_9
            app.EditField_9 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_9.Position = [561 175 50 22];

            % Create RBCLabel_4
            app.RBCLabel_4 = uilabel(app.UIFigure);
            app.RBCLabel_4.FontName = 'Arial';
            app.RBCLabel_4.FontWeight = 'bold';
            app.RBCLabel_4.Position = [505 146 49 23];
            app.RBCLabel_4.Text = 'RBC %';

            % Create EditField_10
            app.EditField_10 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_10.Position = [561 146 50 22];

            % Create WBCLabel_5
            app.WBCLabel_5 = uilabel(app.UIFigure);
            app.WBCLabel_5.Position = [503 92 49 17];
            app.WBCLabel_5.Text = 'WBC';

            % Create EditField_11
            app.EditField_11 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_11.Position = [537 92 39 17];

            % Create RBCLabel_5
            app.RBCLabel_5 = uilabel(app.UIFigure);
            app.RBCLabel_5.Position = [599 90 49 21];
            app.RBCLabel_5.Text = 'RBC';

            % Create EditField_12
            app.EditField_12 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_12.Position = [637 91 42 19];

            % Create TOTALBLOODCELLSLabel_3
            app.TOTALBLOODCELLSLabel_3 = uilabel(app.UIFigure);
            app.TOTALBLOODCELLSLabel_3.FontSize = 8;
            app.TOTALBLOODCELLSLabel_3.FontWeight = 'bold';
            app.TOTALBLOODCELLSLabel_3.Position = [503 59 90 25];
            app.TOTALBLOODCELLSLabel_3.Text = 'TOTAL BLOOD CELLS';

            % Create EditField_13
            app.EditField_13 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_13.Position = [595 61 50 23];

            % Create WBCLabel_6
            app.WBCLabel_6 = uilabel(app.UIFigure);
            app.WBCLabel_6.FontName = 'Arial';
            app.WBCLabel_6.FontWeight = 'bold';
            app.WBCLabel_6.Position = [505 36 49 21];
            app.WBCLabel_6.Text = 'WBC %';

            % Create EditField_14
            app.EditField_14 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_14.Position = [561 35 50 22];

            % Create RBCLabel_6
            app.RBCLabel_6 = uilabel(app.UIFigure);
            app.RBCLabel_6.FontName = 'Arial';
            app.RBCLabel_6.FontWeight = 'bold';
            app.RBCLabel_6.Position = [505 6 49 23];
            app.RBCLabel_6.Text = 'RBC %';

            % Create EditField_15
            app.EditField_15 = uieditfield(app.UIFigure, 'numeric');
            app.EditField_15.Position = [561 6 50 22];

            % Create Button
            app.Button = uibutton(app.UIFigure, 'push');
            app.Button.Position = [87 305 106 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = USER_INTERFACE_AP1

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end