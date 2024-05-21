// The aim of this code is to use our results on Bielliptic Shimura curves $X_0^D(N)$ to decrease
// the number of pairs $(D,N)$ for which we remain unsure of whether $X_0^D(N)$ has a sporadic point,
// following initial work of Saia 2023. 


// unknown_sporadics: List of all 391 triples [D,N,dcm(X_0^D(N))] consisting of pairs [D,N] 
// for which we are unsure whether X_0^D(N) has a sporadic CM point. In other words, this consists 
// of those (D,N) in the fail_dcm_check list which are not in the no_sporadics list, and such that either 
// X_0^D(N) does not have a degree 2 CM point or X_0^D(1) has infinitely many degree 2 points. 

load "unknown_sporadics.m";

load "shimura_curve_CM_locus.m";

load "no_sporadics_XD0.m";

// extra_unknowns_X1: list of 10 pairs [D,N] which are not in unknown_sporadics and
// for which we are unsure whether X_1^D(N) has a sporadic CM point. 
extra_unknowns_X1 := [ [ 6, 5 ],
    [ 6, 7 ],
    [ 6, 13 ],
    [ 6, 19 ],
    [ 6, 29 ],
    [ 6, 31 ],
    [ 6, 37 ],
    [ 10, 7 ],
    [ 14, 5 ],
    [ 22, 5 ],
    [91, 5]]; 


// delta_eq2: list of (D,N) such that X_0^D(N) provably has infinitely many degree 2 points
// (so this has pairs with delta = 1 and delta = 2; includes g=0 and g=1)

g_eq0 := [[6,1],[10,1],[22,1]];
g_eq1 := [[6,5],[6,7],[6,13],[10,3],[10,7],[14,1],[15,1],[21,1],[33,1],[34,1],[46,1]];
hyp_ell := [[6,11],[6,19],[6,29],[6,31],[6,37],[10,11],[10,23],[14,5],[15,2],[22,3],[22,5],[35,1],
	[38,1],[39,1],[39,2],[51,1],[55,1],[58,1],[62,1],[69,1],[74,1],[86,1],[87,1],[94,1],[95,1],[111,1],
	[119,1],[134,1],[146,1],[159,1],[194,1],[206,1]];
biell_delta_eq2 := [[6,17],[6,23],[6,41],[6,71],[10,13],[10,17],[10,29],[22,7],[22,17]];
delta_eq2 := Sort(((hyp_ell cat biell_delta_eq2) cat g_eq1) cat g_eq0);


// has_sporadic_CM_X0: list of pairs [D,N] for which we know X_0^D(N) has a sporadic CM point, 
// by virtue of having a degree 2 CM point and not having infinitely many deg 2 points

has_sporadic_CM_X0 := [];

for triple in unknown_sporadics do
	if triple[3] eq 2 then
		pair := [triple[1],triple[2]];
		if not (pair in delta_eq2) then 
			Append(~has_sporadic_CM_X0,pair);
		else
			Append(~no_sporadics_XD0,pair);
		end if;
	end if;
end for; 


// SetOutputFile("has_sporadic_CM_X0.m");
// print has_sporadic_CM_X0;
// UnsetOutputFile();

Sort(~no_sporadics_XD0);

// SetOutputFile("new_no_sporadics_XD0.m");
// print no_sporadics_XD0;
// UnsetOutputFile();



// new_unknowns_X0: narrowed list of triples [D,N,d_CM(X_0^D(N))], where [D,N] is such that
// we remain unsure whether X_0^D(N) has a sporadic point

new_unknowns_X0 := [];

for triple in unknown_sporadics do
	pair := [triple[1],triple[2]];
	if (not (pair in has_sporadic_CM_X0)) and (not (pair in (delta_eq2))) then
		Append(~new_unknowns_X0,triple);
	end if;
end for;


// SetOutputFile("new_unknowns_X0.m");
// print new_unknowns_X0;
// UnsetOutputFile();


// no_sporadic_CM_X1: pairs [D,N] for which we determine that X_1^D(N) has no sporadic CM points
// by virtue of X_0^D(N) having infinitely many degree 2 points and having 
// delta(X_1^D(N)) \leq Max(2,phi(N)) \leq d_CM(X_1^D(N))

no_sporadic_CM_X1 := [];

for pair in biell_delta_eq2 do
	dcm := d_CM_XD1(pair[1],pair[2])[4];
	if Max(2,EulerPhi(pair[2])) le dcm then 
		Append(~no_sporadic_CM_X1,pair);
	end if;
end for; 


// SetOutputFile("no_sporadic_CM_X1.m");
// print no_sporadic_CM_X1;
// UnsetOutputFile();


// has_sporadic_CM_X1: list of pairs [D,N] for which we know X_1^D(N) has a sporadic CM point, 
// by virtue of having a degree 2 CM point and not having infinitely many deg 2 points

has_sporadic_CM_X1 := [];

for triple in unknown_sporadics do
	D := triple[1];
	N := triple[2];
	dcm := d_CM_XD1(D,N)[4];
	if dcm eq 2 then
		pair := [D,N];
		if not (pair in delta_eq2) then 
			Append(~has_sporadic_CM_X1,pair);
		end if;
	end if;
end for; 

for pair in extra_unknowns_X1 do 
	D := pair[1];
	N := pair[2];
	dcm := d_CM_XD1(D,N)[4];
	if dcm eq 2 then
		if not (pair in delta_eq2) then 
			Append(~has_sporadic_CM_X1,pair);
		end if;
	end if;
end for; 

Sort(~has_sporadic_CM_X1);


// SetOutputFile("has_sporadic_CM_X1.m");
// print has_sporadic_CM_X1;
// UnsetOutputFile();



// new_unknowns_X1: narrowed list of triples [D,N,d_CM(X_1^D(N))], where [D,N] is such that
// we remain unsure whether X_1^D(N) has a sporadic point.

new_unknowns_X1 := [];

for triple in unknown_sporadics do
	pair := [triple[1],triple[2]];
	dcm := d_CM_XD1(pair[1],pair[2])[4];
	if (not (pair in has_sporadic_CM_X1)) and (not (pair in no_sporadic_CM_X1)) then
		Append(~new_unknowns_X1,[pair[1],pair[2],dcm]);
	end if;
end for;

for pair in extra_unknowns_X1 do 
	dcm := d_CM_XD1(pair[1],pair[2])[4];
	if (not (pair in has_sporadic_CM_X1)) and (not (pair in no_sporadic_CM_X1)) then
		Append(~new_unknowns_X1,[pair[1],pair[2],dcm]);
	end if;
end for;

Sort(~new_unknowns_X1); 

// SetOutputFile("new_unknowns_X1.m");
// print new_unknowns_X1;
// UnsetOutputFile();










