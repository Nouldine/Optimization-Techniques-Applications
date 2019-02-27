
Set
	i / W "WineGlass", B "BeerGlass", C "ChampagneGlass", WH "WhiskeyGlass" /, 
	j / M "Molding", P "Packaging Time", G "Glass", S "Selling Price"/,
	t / M "Molding", P "Packaging Time", G "Glass"/;

Table ressources(j, i ) "Table of ressouces " 
	W	B	C	WH
M	4	9	7	10
P	1	1	3	40
G	3	4	2	1
S	6	10	9	20 
;

Table dual_ressources(i, t) "Dual ressources"
	M	P	G	
W	4	1	3	
B	9	1	4	
C	7	3	2	
WH	10	40	1
;

Parameter data(t) "Condition boundaries"
/
M 600
P 400
G 500
/;
 
Free variables 
	revenue "get the maximum", 
	min_revenue "get the duality";


Variables
	
	x(i) "reference to the elements in the set",
	y(t) "reference the duality elements in the set";

Equations 
	objective, 
	objective_2,
	molding_constraint, 
	packaging_constrant,
	glass_constraint,
	common_constraint(i),
	wine_constraint,
        beer_constraint,
        champagne_constraint,
	wiskey_constraint, 
	common_constraint_2(t);

********************************* Model_1 **************************
objective.. revenue =e= sum(i, x(i) * ressources("S", i ) );

molding_constraint.. sum( i, x(i) * ressources("M", i ) ) =l= 600;

packaging_constrant.. sum( i, x(i) * ressources("P", i ) ) =l= 400;

glass_constraint.. sum(i, x(i) * ressources("G", i )) =l= 500;

common_constraint(i).. x(i) =g= 0; 


*************************************** Model_2 *************************

objective_2.. min_revenue =e= sum( t, data(t) * y(t) );

wine_constraint..  sum(t, dual_ressources("W", t) * y(t) )  =g= 6;

beer_constraint..  sum( t, dual_ressources("B", t ) * y(t) ) =g= 10;

champagne_constraint.. sum( t, dual_ressources("C", t ) * y(t) ) =g= 9;

wiskey_constraint.. sum(t, dual_ressources("WH", t ) * y(t) ) =g= 20; 

common_constraint_2(t).. y(t) =g= 0;

Model 	
	Prob_2 /all/,
	Prob_2_2 /all/;

Solve Prob_2 using lp maximizing revenue;
Solve Prob_2_2 using lp minimizing min_revenue;

display Prob_2.objval;
Display  Prob_2_2.objval;




