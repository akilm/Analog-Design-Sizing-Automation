function Pd = Dynamic_Power(Gate_type,no_inputs,C_out,C_in,Vdd,f)
    
    P = zeros(1,length(Gate_type));
    alpha = zeros(1,length(Gate_type));
    for i = 1:length(Gate_type)
           switch(Gate_type(i))
               case 'NAND'
                   if i == 1
                        P(i) =1 - 0.5^no_inputs(i);
                   else
                        P(i) = 1-P(i-1)^no_inputs(i);
                   end
                   alpha(i) = P(i)*(1-P(i));
               case 'NOR'
                   if i == 1
                        P(i) = 0.5^no_inputs(i);
                   else
                        P(i) = (1-P(i-1))^no_inputs(i);
                   end
                   alpha(i) = P(i)*(1-P(i));
               case 'INV'
                   if i == 1
                       P(i) = 1- 0.5;
                   else
                       P(i) = 1-P(i-1);
                   end
                   alpha(i) = P(i)*(1-P(i));
           end
    end
    Pd = 0;
    for i = 1:length(Gate_type)
        Pd =Pd + alpha(i)*(C_out(i)*10^-15)*(Vdd^2)*f;
end