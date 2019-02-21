
$ontext
* Ex 1.12 Murty LP
A forestry company has four sites on which they grow trees.
They are considering four species of trees, the pines, spruces,
walnuts and other hardwoods.   Data on the problem are given below.

\begin{tabular}
Site & Area (ka) & \multicolumn{4}{c}{Expected annual yield ($m^3/ka$)} & \multicolumns{4}{c}{Expected annual revenue (money units per ka)} \\
Number & & Pine & Spruce & Walnut & Hardwood & Pine & Spruce & Walnut & Hardwood \\
1 & 1500 &   17 & 14 & 10  & 9   & 16 & 12 & 20 & 18 \\
2 & 1700   & 15 & 16 & 12 & 11   & 14 & 13 & 24 & 20 \\
3 & 900   & 13 & 12 & 14  & 8   & 17 & 10 & 28 & 20 \\
4 & 600   & 10 & 11  & 8  & 6   & 12 & 11 & 18 & 17 \\
\multicolumn{2}{l}{Minumum required yield} & 22.5 & 9 & 4.8 & 3.5
\end{tabular}

How much area should the company devote to the growing of various species
in the various sites?
$offtext

Set 
	site /1*4/
	species / p "pine", s "spruce", w "walnut", h "hardwood"/;

Parameter area(site) "area at site in ka " 
/
1 1500
2 1700
3 900
4 600
/

Table yield(site, species) "m^3 per ka"
	p	s	w	h
1	17	14	10	9 
2	15	16	12	11
3	13	12	14	8
4	10	11	8	6
;

Table revenue(site, species ) "$ in ka"
	p	s 	w	h
1	16	12	20	18
2	14	13	24	20
3	17	10	28	20 
4	12	11	18	17 
;

Parameter minyield(species) "minimal required yield (km^3)" 
/ 
p 22.5 
s 9
w 4.8
h 3.5
/;

* Convert units 
minyield(species) = 1000 * minyield(species);

* variables
Positive variable 
	grow(site, species) 'Number of species that could be grown in each site'; 

Variable
	profit 'Profit that needs to be optimized'; 

Equations 
	objective, 
	species_constraint(species) 'constraint for species',
	site_constraint(site) 'constraint for the  area that need to be allocated';

species_constraint(species).. sum( site, grow(site, species)  * yield( site, species )) =g=  minyield(species);
site_constraint(site).. sum(species, grow(site, species )) =l= area(site);
Objective.. profit =e= sum((site, species ), grow( site, species ) * revenue( site, species )); 


Model Prob2 /all/;

Solve Prob2 using lp maximizing  profit;

display Prob2.objval;



