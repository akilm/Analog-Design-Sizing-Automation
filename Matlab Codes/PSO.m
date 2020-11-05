function [Power_g,Delay_g,Gbest,fit_val,f_max,Delay] = PSO(N,Population,logic_string,Cload,gamma,f,Target_um,FO_4,Vdd,Cg,Cd,pinv,Wpower,Wdelay,stages)
 w = rand(Population,stages)*(200-1)*0.18 + 0.18  %%unifrnd(0.18,100*0.18,Population,stages);
 Power = zeros(1,Population);
 Delay = zeros(1,Population);
 Personal_best_width = w ;
 Personal_best_fitness = zeros(1,Population);
 fitness_current = zeros(1,Population);
 velocity = unifrnd(0,10,Population,stages);
 Gbest = zeros(N,stages) ;

 for i = 1:N
    
    for j = 1:Population
        %%Compute Fitness values
        for k=1:stages
            W(k) = w(j,k)
        end
        [Power(j),Delay(j)] = fitness(logic_string,Cload,gamma,f,Target_um,FO_4,Vdd,Cg,Cd,W,pinv);
        fitness_current(j) = ((Wpower*exp(-Power(j)/1000)) + (Wdelay*exp(-Delay(j)/1000)))/(sqrt(Wpower^2 + Wdelay^2));
   
        %%Update Personal best location and fitness value
        if(fitness_current(j)>Personal_best_fitness(j))
            Personal_best_fitness(j) = fitness_current(j);
            for k = 1:stages
                Personal_best_width(j,k) = w(j,k);
            end
        else
            %% Do nothing , Previous Values retained
        end 
    end
    
    %%Update global best location
    [minP,index] = max(Personal_best_fitness);
    for k = 1:stages
        Gbest(i,k) = Personal_best_width(index,k);
    end
        
    %%Velocity and position update
    for j = 1:Population
        r1 = unifrnd(0,1);
        r2 = unifrnd(0,1);
        for k = 1:stages
            velocity(j,k) = velocity(j,k) + 0.2*r1*(Personal_best_width(j,k) - w(j,k)) + 0.2*r2*(Gbest(i,k) - w(j,k));   
            w(j,k) = w(j,k) + velocity(j,k);
            if(w(j,k)<0)
                w(j,k)=-1*w(j,k);
            end
        end  
    end
   fit_val(i) = mean(fitness_current)
   [f_max(i),index] = max(fitness_current)
   Power_g(i) = Power(index);
   Delay_g(i) = Delay(index);
 end
 