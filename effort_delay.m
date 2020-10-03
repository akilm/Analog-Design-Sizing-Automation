function [d,C_in,g,h] = d(LOGIC_String,Width,gamma,C_L,Pinv)
    stage = split(LOGIC_String)
    C_in = zeros(1,length(stage))
    C_out = zeros(1,length(stage))
    g = zeros(1,length(stage))
    h = zeros(1,length(stage))
    p = zeros(1,length(stage))
    for i = 1:length(stage)
       str = split(stage(i),'-')
       No_inputs = str2double(cell2mat(str(1)))
       disp(No_inputs+1)
       Gate_Type = string(str(2))
       No_Branches(i) = cell2mat(str(3))
       C_in(i) =  Cin_tot(No_inputs,Gate_Type,Width(i),gamma)
       g(i) = logic_effort(Gate_Type,No_inputs)
       p(i) = parasitic_delay(Gate_Type,No_inputs,1)
    end
    for i = 1:length(stage)
        if i ~= length(stage)
            C_out(i) = C_in(i+1)*No_Branches(i+1)
        else
            C_out(i) = C_L
        end
    end
    for i = 1:length(stage)
        h(i) = C_out(i)/C_in(i)
    end
    d = 0
    for i = 1:length(stage)
        d = d+p(i)+g(i)*h(i)
    end
end