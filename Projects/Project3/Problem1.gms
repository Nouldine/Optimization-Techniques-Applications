
Set 
	j /1*3/

Free variable maximum "get the maximum"

Variables 
	y(j) "get the duality set";

Equations 
	objective_1,
	constraint_d_1 "equation for duality constraint one",
        constraint_d_2 "equation for duality constraint two",
        constraint_d_3 "equation for duality constraint three",
	common_constraint_1(j) "common constraint for duality";

objective_1.. maximum =e= -15*y("1") - 12*y("2") + 3*y("3"); 
constraint_d_1.. -y("1") - 9*y("2") + 5*y("3") =l= 3; 
constraint_d_2.. -4*y("1") + 9*y("3") =l= 2; 
constraint_d_3.. -y("1") - 6*y("2") =l= -33;
common_constraint_1(j).. y(j) =g= 0;

Model Prob_1_1 /all/;
Solve Prob_1_1 using lp maximizing maximum;
display Prob_1_1.objval;


