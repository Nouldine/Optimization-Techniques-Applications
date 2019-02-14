
$offsymxref offsymlist offuelxref offuellist offupper

option limrow = 0, limcol = 0;

free variable min "minimum";

positive Variables
x1	"variable one",
x2	"variable two",
x3	"variable three";

Parameter 
	objval,
	x1val,
	x2val, 
	x3val;

Equations
objective	"the minimum",
equa1	"equation one",
equa2	"equation two",
equa3	"equation three";

objective..
min =e= 3*x1 + 2*x2 - 33*x3;

equa1..
x1 - 4*x2 + x3 =l= 15;

equa2..
9*x1 + 6*x3 =e= 12;

equa3..
5*x1 + 9*x2 =g= 3;

model equation_one /all/;
solve equation_one using lp minimizing min;

objval = objective.l;
x1val = x1.l;
x2val = x2.l;
x3val = x3.l;

display objval, x1val, x2val, x3val;



