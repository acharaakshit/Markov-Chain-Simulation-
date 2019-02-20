% Fixing random number generation seed.
rand('state',0);


noOfStates = 3;

% no of realizations
n = 15;


transitionMatrix = [0 1 0;0 0 1;0.05 0 0.95];

Markov_Chain = dtmc(transitionMatrix);
figure;
graphplot(Markov_Chain);

initialProbabilityState = [0, 0, 1];

% Calculating Trainsition Matrix at n=5, n=10, n=15 and n=20
P_5 = initialProbabilityState*(transitionMatrix^5);
P_10 = initialProbabilityState*(transitionMatrix^10);
P_15 = initialProbabilityState*(transitionMatrix^15);
P_20 = initialProbabilityState*(transitionMatrix^20);

fprintf('At time n=5');
disp(P_5(3));
fprintf('\nAt time n=10');
disp(P_10(3));
fprintf('\nAt time n= 15 ');
disp(P_15(3));
fprintf('\nAt time n=20');
disp(P_20(3));


states = 1;     
simulation = unifrnd(0, 1, 1,n);   

% Performing simulation
for i = 1:n
    cumulativeMatrix = cumsum([0, transitionMatrix(states(end), :)]);
    
    for j = 1:noOfStates
        
        if(cumulativeMatrix(j) <= simulation(i) && simulation(i) < cumulativeMatrix(j+1))
            states = [states,j];    
        end
    end
end

% Plot (State vs Time)
figure();
stem(states, 'LineWidth', 2, 'Marker', '.', 'MarkerSize', 24);
title('15 Realizations');
xlabel('Time (N)');
ylabel('State (X_n)');

ax = gca;
ax.FontSize = 12;
ax.TickLength = [0.02 0.02];
ax.XTick = 1:n+1;
ax.YTick = 1:3;

max_err = 0.000001;     
k = 2;      


while(1)
    differenceMatrix = transitionMatrix^k - transitionMatrix^(k-1);     
    
    if(length(differenceMatrix(differenceMatrix < max_err)) == noOfStates*noOfStates)       
        break  
    end
    
    k = k+1;
end

limitingProbabilityMatrix = transitionMatrix^k;    

fprintf('Limiting Probability Matrix is:\n');
disp(limitingProbabilityMatrix);
fprintf('After a certain number k, the difference between consecutive states');
fprintf('becomes negligible\n');
fprintf('Therefore, the limiting distribution for each state is given by: π = (%.4f, %.4f, %.4f).\n', limitingProbabilityMatrix(1,:)); 
