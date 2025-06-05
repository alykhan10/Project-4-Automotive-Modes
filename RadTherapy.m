% Define optimization problem
prob = optimproblem("Description","Radiation Therapy Optimization");

% Define 8 beam intensities (non-negative)
I = optimvar("I", 8, "LowerBound", 0);

% Define tumor dose as weighted sum of beam intensities
d = [10 7 3 8 8 5 9 10];
D = d * I;

% Set objective function for tumor dose
prob.Objective = D;

% Set constraint for spinal cord dose
prob.Constraints.spinal = 2*I(3) + 2*I(7) <= 5;

% Dose constraints for tumor regions A–D
prob.Constraints.A = 3*I(2) + 3*I(6) >= 7;
prob.Constraints.B = 3*I(3) + 2*I(6) >= 7;
prob.Constraints.C = 4*I(3) + 2*I(5) >= 7;
prob.Constraints.D = 2*I(4) + I(7) >= 7;

% Solve optimization problem
sol = solve(prob);

% Plot optimal beam intensities
bar(sol.I)

% Evaluate spinal cord dose from solution
spinalCordDose = 2*I(3) + 2*I(7);
check = evaluate(spinalCordDose, sol);