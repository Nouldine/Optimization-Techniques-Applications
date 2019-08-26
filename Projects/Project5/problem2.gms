option limrow=0, limcol=0, solprint = off;

$setglobal n 5

Set i 
	/1*%n%/;
Alias (
	i,j);

Integer variables 
	click(i,j);

Variables 
	totclicks;
Integer variables 
	cancels(i,j);

Equations 
	turnoff(i,j), 
	cost;

scalar initclicks "how many clicks to turn off from init state",
       period "how many clicks to get back to same state";

turnoff(i,j)..
  initclicks + period*cancels(i,j) =e=
  click(i,j) + click(i-1,j) + click(i+1,j) + click(i,j-1) + click(i,j+1);

cost..
  totclicks =e= sum((i,j), click(i,j));

model lightsout /all/;

lightsout.optcr = 0;
lightsout.optca = 0.999;
lightsout.reslim = 4000;
lightsout.iterlim = 1000000000;

Parameter 
	soln(*,*);

period = 2
;
cancels.up(i,j) = period;
click.up(i,j) = 1;
initclicks = 1;

solve lightsout using mip min totclicks;
option click:0:0:1; display click.l;
soln('simple','totclick') = totclicks.l;


option soln:0:1:1; display soln;

Parameter 
	solnhigh(*,*);

period = 4
;
cancels.up(i,j) = period;
click.up(i,j) = 3;
initclicks = 1;
solve lightsout using mip min totclicks;
option click:0:0:1; display click.l;
solnhigh('high','totclick') = totclicks.l;

option solnhigh:0:0:1; display solnhigh;

Parameter 
	solnmed(*,*);

period = 4
;
cancels.up(i,j) = period;
click.up(i,j) = 3;
initclicks = 2;
solve lightsout using mip min totclicks;
option click:0:0:1; display click.l;
solnmed('medium','totclick') = totclicks.l;


Option solnmed:0:0:1; display solnmed;

Parameter 
	solnlow(*,*);

period = 4
;
cancels.up(i,j) = period;
click.up(i,j) = 3;
initclicks = 3;

Solve lightsout using mip min totclicks;

Option click:0:0:1; display click.l;
solnlow('low','totclick') = totclicks.l;



