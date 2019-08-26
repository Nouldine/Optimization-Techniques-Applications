$Title Electrical Power Distribution Network

Option limrow = 8, limcol = 100, solprint = off; 

Sets
	node / 1*8 /
	Arcs( node, node )
;
	
Alias
	( node, i, j )
;

Parameter

	supply(node) / 1  100, 2 -35, 3 0, 4 60, 5 -50, 6  -60, 7 80, 8 -95 /
;

Parameter 
	Cost( node, node )
;

Scalar 
	Cost_MWH /11/
;

Parameter Connections( node, node )/ 

 	1.2	1
	2.1	1
	4.5	1
	5.4	1
	7.2	1
	2.7	1
	7.6	1
	6.7	1
	2.3	1
	3.2	1
	4.3	1
	3.4	1
	5.3	1
	3.5	1
	1.8	1
	4.8	1
	7.8	1 
/;

Arcs( i, j ) = yes$( Connections( i, j ) GT 0 );

Cost(i, j)$Arcs( i, j ) = Cost_MWH;

Cost('1', j )$Arcs('1', j ) = 15 + Cost_MWH;
Cost('4', j )$Arcs('4', j ) = 13.5 + Cost_MWH;
Cost('7', j )$Arcs('7', j ) = 21 + Cost_MWH;

Cost(node,'8')$Arcs( node, '8' ) = 0; 

Positive Variables

	flow( node, node ) 

Variable
	Total_cost;

Equations
	Objective
	Flow_balance(node)
;

Objective.. Total_cost =e=  sum( Arcs, Cost(Arcs) * flow(Arcs) );

Flow_balance(i).. sum(j$Arcs( i, j ), flow( i, j )) - sum(j$Arcs( j, i ), flow( j, i )) =e= supply( i );

Model mcf / All /;
Solve mcf using lp minimizing Total_cost;

Display flow.l;
