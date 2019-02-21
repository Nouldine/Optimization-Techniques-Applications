
Set
	j / 1*3 /

Free variable maximum "Maximum";

Variables

	x(j) "get set of variables"
  	
Equations 
	obj		"The Maximum",
	sum_equation	"This is the summation constraint";

obj .. maximum =e= 5*( x("1") + 2 * x("2") ) - 11 * ( x("2") - x("3") );

sum_equation.. 3*x("1") =g= sum(j, x(j) );  

x.lo(j) = 0; 
x.up(j) = 3;

Model  prob2 /all/; 

solve prob2 using lp maximizing maximum;

display x.l, x.lo, x.up, prob2.objval;


