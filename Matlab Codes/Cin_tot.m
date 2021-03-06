function [Cin_arr,Cout_arr] = Cin_tot(No_inputs,Gate_Type,Width,gamma,Cg,Cd)
    switch Gate_Type
        case 'INV'
            Cin_arr  = (gamma+1)*Width*Cg
            Cout_arr = (gamma+1)*Width*Cd 
        case 'NAND'
            Cin_arr = (gamma+No_inputs)*Width*Cg
            Cout_arr = (No_inputs*gamma + No_inputs)*Width*Cd
        case 'NOR'
            Cin_arr = (No_inputs*gamma+1)*Width*Cg
            Cout_arr = (No_inputs*gamma + No_inputs)*Width*Cd
    end
    
end