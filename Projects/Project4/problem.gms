$title Malfoy Catering 

$onecho > cplex.opt
lpmethod	3 
netfind		2
preind		0
names		no 
$offecho

Sets 
	Nodes			/t1*t10, h1*h10, store, trash/
	T(Nodes)		/t1*t10/ 
	H(Nodes)		/h1*h10/ 
	Arcs(Nodes, Nodes)
;

Parameters 
	d(T) / t1 50, t2 60, t3	 80, t4 70, t5 50, t6 60, t7 90, t8 80, t9 90, t10 100 / 
	c(Nodes, Nodes) 
	b(Nodes) 
;

Scalars 
	alpha		/200/
	beta		/75/
	gamma		/25/ 
	p 		/4/ 
	q		/2/ 
	MM		/5000/ 
; 

Alias 
	(Nodes, I, J);

Alias
	( H, H1, H2 ); 


* Put arc from last hamper to trash 
Arcs('store', T ) = yes; 
c('store', T ) = alpha; 

* Put arc from last hamper to trash
Arcs('h10', 'trash') = yes;

* Put arc from storen to trash
Arcs('store', 'trash') = yes;

* Put arcs from hamper node to demand nodes
Arcs( H, T ) = yes$((ord(T) = ord(H) + q ) or ( ord(T) = ord(H) + p )); 
c( H, T )$(ord(T) = ord(H) + q ) = beta; 
c( H, T )$(ord(T) = ord(H) + p ) = gamma; 

* Put arcs from hamper nodes to hamper nodes 
Arcs( H1, H2 ) = yes$( ord(H2) =  ord(H1) + 1 );

Display Arcs; 

* Set up b. First for demand nodes 

b(T) = -d(T); 

* Now for hampers. ( This one is bit strange, but it works )
b(H) = sum(T$(ord(T) = ord(H)), d(T));


* Now for store and trash

b('store') = MM; 
b('trash') = -MM; 

Display b;

* Define the  right variable  

Positive variables 
	X(Nodes, Nodes); 

Variables
	TotalCost; 

Equations 
	Objective_equa 
	Flow_balance(Nodes)
;

Objective_equa.. TotalCost =e= sum(Arcs, c(Arcs) * X(Arcs)); 

Flow_balance(I).. sum(J$Arcs(I,J), X(I,J)) - sum(J$Arcs(J, I), X(J, I)) =e= b(I);

Model MalfoyCatering /all/; 
Solve MalfoyCatering  using lp minimizing TotalCost; 

Parameters 
	Cost
	NumEqu 
	NumBought
; 

Cost = TotalCost.L; 
NumEqu = MalfoyCatering.numequ; 
NumBought = sum( T, x.L('store', T));

Display Cost, NumEqu; 
Display NumBought;


