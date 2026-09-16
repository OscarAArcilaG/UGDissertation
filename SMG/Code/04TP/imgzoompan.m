function imgzoompan(hfig, varargin)
    if isempty(findobj('type','figure'))
        fprintf('%s -- finds no open figure windows. Quitting.\n', mfilename)
        return
    end
    if nargin==0 || isempty(hfig) || ~isa(hfig,'matlab.ui.Figure')
        hfig = gcf;
    end
    p = inputParser;
    p.addOptional('Magnify', 1.1, @isnumeric);
    p.addOptional('XMagnify', 1.0, @isnumeric);
    p.addOptional('YMagnify', 1.0, @isnumeric);
    p.addOptional('ChangeMagnify', 1.1, @isnumeric);
    p.addOptional('IncreaseChange', 1.1, @isnumeric);
    p.addOptional('MinValue', 1.1, @isnumeric);
    p.addOptional('MaxZoomScrollCount', 30, @isnumeric);
    p.addOptional('ImgWidth', 0, @isnumeric);
    p.addOptional('ImgHeight', 0, @isnumeric);
    p.addOptional('PanMouseButton', 2, @isnumeric);
    p.addOptional('ResetMouseButton', 3, @isnumeric);
    p.addOptional('ButtonDownFcn',  @(~,~) 0);
    p.addOptional('ButtonUpFcn', @(~,~) 0) ;
    parse(p, varargin{:});
    opt = p.Results;
    if opt.Magnify<opt.MinValue
        opt.Magnify=opt.MinValue;
    end
    if opt.ChangeMagnify<opt.MinValue
        opt.ChangeMagnify=opt.MinValue;
    end
    if opt.IncreaseChange<opt.MinValue
        opt.IncreaseChange=opt.MinValue;
    end
    set(hfig, 'WindowScrollWheelFcn', @zoom_fcn);
    set(hfig, 'WindowButtonDownFcn', @down_fcn);
    set(hfig, 'WindowButtonUpFcn', @up_fcn);
    zoomScrollCount = 0;
    orig.h=[];
    orig.XLim=[];
    orig.YLim=[];
    function zoom_fcn(src, cbdata)
        scrollChange = cbdata.VerticalScrollCount;
        if ((zoomScrollCount - scrollChange) <= opt.MaxZoomScrollCount)
            axish = gca;
            if (isempty(orig.h) || axish ~= orig.h)
                orig.h = axish;
                orig.XLim = axish.XLim;
                orig.YLim = axish.YLim;
            end
            cpaxes = mean(axish.CurrentPoint);
            newXLim = (axish.XLim - cpaxes(1)) * (opt.Magnify * opt.XMagnify)^scrollChange + cpaxes(1);
            newYLim = (axish.YLim - cpaxes(2)) * (opt.Magnify * opt.YMagnify)^scrollChange + cpaxes(2);
            newXLim = floor(newXLim);
            newYLim = floor(newYLim);
            if (opt.ImgWidth > 0)
                if (newXLim(1) >= 0 && newXLim(2) <= opt.ImgWidth && newYLim(1) >= 0 && newYLim(2) <= opt.ImgHeight)
                    axish.XLim = newXLim;
                    axish.YLim = newYLim;
                    zoomScrollCount = zoomScrollCount - scrollChange;
                else
                    axish.XLim = orig.XLim;
                    axish.YLim = orig.YLim;
                    zoomScrollCount = 0;
                end
            else
                axish.XLim = newXLim;
                axish.YLim = newYLim;
                zoomScrollCount = zoomScrollCount - scrollChange;
            end
        end
    end
    function down_fcn(hObj, evt)
        opt.ButtonDownFcn(hObj, evt);
        clickType = evt.Source.SelectionType;
        panBt = opt.PanMouseButton;
        if (panBt > 0)
            if (panBt == 1 && strcmp(clickType, 'normal')) || ...
                (panBt == 2 && strcmp(clickType, 'alt')) || ...
                (panBt == 3 && strcmp(clickType, 'extend'))
                guiArea = hittest(hObj);
                parentAxes = ancestor(guiArea,'axes');
                if ~isempty(parentAxes)
                    startPan(parentAxes)
                else
                    setptr(evt.Source,'forbidden')
                end
            end
        end
    end
    function up_fcn(hObj, evt)
        opt.ButtonUpFcn(hObj, evt);
        clickType = evt.Source.SelectionType;
        resBt = opt.ResetMouseButton;
        if (resBt > 0 && ~isempty(orig.XLim))
            if (resBt == 1 && strcmp(clickType, 'normal')) || ...
                (resBt == 2 && strcmp(clickType, 'alt')) || ...
                (resBt == 3 && strcmp(clickType, 'extend'))
                guiArea = hittest(hObj);
                parentAxes = ancestor(guiArea,'axes');
                parentAxes.XLim=orig.XLim;
                parentAxes.YLim=orig.YLim;
            end
        end
        stopPan
    end
    function startPan(hAx)
        hFig = ancestor(hAx, 'Figure', 'toplevel');
        seedPt = get(hAx, 'CurrentPoint');
        seedPt = seedPt(1, :);
        hAx.XLimMode = 'manual'; 
        hAx.YLimMode = 'manual';
        set(hFig,'WindowButtonMotionFcn',{@panningFcn,hAx,seedPt});
        setptr(hFig, 'hand');
    end
    function stopPan
        set(gcbf,'WindowButtonMotionFcn',[]);
        setptr(gcbf,'arrow');
    end
    function panningFcn(~,~,hAx,seedPt)
        currPt = get(hAx,'CurrentPoint');
        XLim = hAx.XLim;
        YLim = hAx.YLim;
        x_seed = (seedPt(1)-XLim(1))/(XLim(2)-XLim(1));
        y_seed = (seedPt(2)-YLim(1))/(YLim(2)-YLim(1));
        x_curr = (currPt(1,1)-XLim(1))/(XLim(2)-XLim(1));
        y_curr = (currPt(1,2)-YLim(1))/(YLim(2)-YLim(1));
        deltaX = x_curr-x_seed;
        deltaY = y_curr-y_seed;
        newXLims(1) = -deltaX*diff(XLim)+XLim(1);
        newXLims(2) = newXLims(1)+diff(XLim);
        newYLims(1) = -deltaY*diff(YLim)+YLim(1);
        newYLims(2) = newYLims(1)+diff(YLim);
        newXLims = round(newXLims);
        newYLims = round(newYLims);
        if (newXLims(1) > 0.0 && newXLims(2) < opt.ImgWidth)
            set(hAx,'Xlim',newXLims);
        end
        if (newYLims(1) > 0.0 && newYLims(2) < opt.ImgHeight)
            set(hAx,'Ylim',newYLims);
        end
    end

end