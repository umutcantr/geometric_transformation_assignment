function transformation
    figure1 = uifigure('Name','Rectangle Translation');
    ax1 = axes('Parent', figure1, 'Position', [0.1 0.2 0.8 0.7]);
    xlabel(ax1,'X');
    ylabel(ax1,'Y');
    title(ax1,'Rectangle Translation');
    xlim(ax1,[0 50]);
    ylim(ax1,[0 50]);

    % Create the translation input box 
    translate_label = uilabel(figure1,'Position',[25 45 120 20],'Text','Translation', 'FontSize',15, 'FontWeight', "bold");
    translate_y_steps_label = uilabel(figure1,'Position',[25 5 60 20],'Text','Y axis:');
    translate_x_steps_label = uilabel(figure1,'Position',[25 25 60 20],'Text','X axis:');
    translate_x_steps_input = uieditfield(figure1,'numeric','Position',[70 25 40 20],'Value',1);
    translate_y_steps_input = uieditfield(figure1,'numeric','Position',[70 5 40 20],'Value',1);

     % Create the scale input box 
    scale_label = uilabel(figure1,'Position',[165 45 120 20],'Text','Scale', 'FontSize',15, 'FontWeight', "bold");
    scale_y_steps_label = uilabel(figure1,'Position',[155 5 60 20],'Text','Y axis:');
    scale_x_steps_label = uilabel(figure1,'Position',[155 25 60 20],'Text','X axis:');
    scale_x_steps_input = uieditfield(figure1,'numeric','Position',[200 25 40 20],'Value',1);
    scale_y_steps_input = uieditfield(figure1,'numeric','Position',[200 5 40 20],'Value',1);

    % Create the translation input box and translate button
    translate_button = uibutton(figure1,'push', ...
        'Position',[250 10 80 20], ...
        'Text','Translate', ...
        'ButtonPushedFcn',@translate);

    % Create the T matrix label
    T_box = uieditfield(figure1,'text','Position',[350 10 150 20],'Value',mat2str(eye(3)),'Editable','off');
    % Create the T matrix edit field
    T_matrix_label = uilabel(figure1,'Position',[350 35 120 20],'Text','T matrix', 'FontSize',15, 'FontWeight', "bold");
 
    % Initial rectangle
    x = [0 10 10 0 0];
    y = [0 0 20 20 0];
    h = plot(ax1,x,y,'LineWidth',2,'Color','red');
  
    function translate(~,~)
        % Get the number of steps for translation
        x_translate = translate_x_steps_input.Value;
        y_translate = translate_y_steps_input.Value;

        % Get the number of steps for scale
        x_scale = scale_x_steps_input.Value;
        y_scale = scale_y_steps_input.Value;

        % Translation matrix: T
        tx = x_translate * 1; % x axis translation value
        ty = y_translate * 1; % y axis translation value
        T = [1 0 tx; 0 1 ty; 0 0 1];
        
        % Scale matrix: S
        sx = x_scale * 1;
        sy = y_scale * 1;
        S = [sx 0 0; 0 sy 0; 0 0 1];

        % Apply translation to rectangle
        p = [x;y;ones(1,5)];  % Homogen coordinats of rectangle 
        p = T * p;
        x = p(1,:);
        y = p(2,:);

        % Apply scale to rectangle
        p = [x;y;ones(1,5)];  % Homogen coordinats of rectangle 
        p = S * p;
        x = p(1,:);
        y = p(2,:);
        
        % Limit x and y axis to 50
        x(x > 50) = 50;
        y(y > 50) = 50;
        
        set(h,'XData',x,'YData',y)
        
        % Set the y axis limit
        ylim(ax1,[0 50]);
        xlim(ax1,[0 50]);
        
        % Update the T matrix edit field
        set(T_box, 'Value', mat2str(T));
    end
end


