$title Alloy blending 

$ontext 
The company Steelco has received an order for 500 tones of steel 
to be used in shipbuilding. The steel must have the following characteristics:

Chemical Element Minimum Grade Maximum Grade 
Carbon 	2	3 
copper(cu)	0.4	0.6
Manganese(Mn)	1.2	1.65


The company has seven different raw material in stock that maybe used for the production of this steel. The followin table lists the grades, available  amounts and pricesfor all materials:

Raw Meterial 	C% 	Cu% 	Mn% 	Available in t cost in  $/t

Iron alloy 	1 	2.5	1.3 	400	200
iron2		3	0.8		300	250 
iron3		90		500	220		
cu1		96	4	200	240	
al1		0.4	1.2	300	200
al2		0.6		250	165 

The objective is to determine the composition of the steel that minimizes the
production cost. 
$offtext 

Set 
	elements / c carbon, cu copper, mn manganese /,
	raw / iron1 * iron3, cu1 * cu2, al1 * al2 /;

table gradereq( elements, * )
	min 	max
c 	2	3
cu	0.4	0.6 
mn	1.2	1.65
;

Table data(raw, * )
	c	cu 	mn 	avail	cost 
iron1	2.5		1.3	400	200 
iron2	3		0.8	300	250 
iron3		0.3		600	150
cu1		90		500	220 
cu2		96	4	200	240 
al1		0.4	1.2	300	200 
al2		0.6		250	165
;

Scalar dem /500/; 

Positive variables 
	use(raw) 'raw material that could be  used';

Variables  
	obj 	'Objective variable'; 

Equations
 	objective 'final blend requirements',	
	balance(raw) 'balance raw available materials',
	production,
	equa_max_constraint(elements) 'equation for maximum limit', 
	equa_min_constraint(elements) 'equation for minimum limit'; 

equa_max_constraint(elements)..  sum( raw, use(raw) * data(raw, elements)) / dem =l= gradereq(elements, "max"); 
equa_min_constraint(elements)..  sum( raw, use(raw) * data(raw, elements)) / dem =g= gradereq(elements, "min"); 

production..  sum( raw, use(raw) ) =e= dem; 
balance(raw)..  use(raw) =l= data( raw, "avail");
objective.. obj =e= sum( raw, data( raw, "cost") * use(raw) );

Model  Prob1 'Alloy blending' /all/;

solve Prob1  using lp minimizing  obj;

display  Prob1.objval, use.l; 

parameter pct(elements) "raw material used percentage"; 

* Calculate the  percentage 

pct(elements) =  sum(raw, use.l(raw) * data(raw, elements )) / dem;
 
display pct;



