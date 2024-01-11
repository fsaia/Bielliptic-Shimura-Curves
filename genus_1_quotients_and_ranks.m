// Using the list of candidate pairs with N squarefree computed in narrow_to_candidates.m
// and the quot_genus function in quot_genus.m for the genus of an Atkin--Lehner quotient
// $X_0^D(N)/\langle w_m \rangle, we determine the genus 1 quotients of this form
// We then determine the rank of the elliptic curve jacobian of each such quotient,
// using Ribet's isogeny. 

load "quot_genus.m";


//``plus" space of the Jacobian of X0(N) wrt w_m

Jplus := function(N,m)
    J0 := JZero(N);
    wm := AtkinLehnerOperator(J0,m);
    Wm := Kernel(-Matrix(wm)+1);
    try
     _,jquotient :=DefinesAbelianSubvariety(J0,Wm);
     catch e
     jquotient :=DefinesAbelianSubvariety(J0,Wm);
     end try;
 return jquotient;
end function;


//``minus" space of the Jacobian of X0(N) wrt w_m

Jminus := function(N,m)
    J0 := JZero(N);
    wm := AtkinLehnerOperator(J0,m);
    Wm := Kernel(Matrix(wm)+1);
    try
     _,jquotient :=DefinesAbelianSubvariety(J0,Wm);
     catch e
     jquotient :=DefinesAbelianSubvariety(J0,Wm);
     end try;
 return jquotient;
end function;


// list of Hall Divisors of a given positive integer N

HallDivisors := function(N)
    return [d : d in Divisors(N) | GCD(d,Integers()!(N/d)) eq 1 and d ne 1];
end function;


// sqfree_candidate_pairs : list of 295 pairs (D,N) with D,N>1, (D,N) = 1, and N squarefree so that X_0^D(N) 
// is possible bielliptic, given that X_0^D(1) is of genus at most 2 or is hyperelliptic or bielliptic
// and that g(X_0^D(N)) is at most 39. 
load "sqfree_candidate_pairs.m";


// not_sqfree_candidate_pairs : list of 55 pairs (D,N) with D,N>1, (D,N) = 1, and N not squarefree so that X_0^D(N) 
// is possible bielliptic, given that X_0^D(1) is of genus at most 2 or is hyperelliptic or bielliptic
// and that g(X_0^D(N)) is at most 39. 

load "not_sqfree_candidate_pairs.m";


// genus_1_quotients_N_sqfree: list of all triples [D,N,m] with D>1, D relatively prime to N,
// N squarefree and m a Hall Divisor of DN such that X_0^D(N)/<w_m> has genus 1
genus_1_quotients_N_sqfree := [];


// genus_1_quotients_N_not_sqfree: list of all triples [D,N,m] with D>1, D relatively prime to N,
// N squarefree and m a Hall Divisor of DN such that X_0^D(N)/<w_m> has genus 1
genus_1_quotients_N_not_sqfree := [];


// rank0: list of triples [D,N,m] in genus_1_quotients_N_sqfree such that J(X_0^D(N)/<w_m>) has rank 0
rank0 := [];


// rank1: list of triples [D,N,m] in genus_1_quotients_N_sqfree such that J(X_0^D(N)/<w_m>) has rank 1
rank1 := [];



// generating list of genus 1 quotients with N squarefree, and
// using Ribet's isogeny to compute ranks of the associated Jacobian for each such quotient

for pair in sqfree_candidate_pairs do
    D := pair[1]; N := pair[2];
    for m in HallDivisors(D*N) do
        if quot_genus(D,N,m) eq 1 then
            Append(~genus_1_quotients_N_sqfree,[D,N,m]);
            if IsEven(#PrimeFactors(GCD(D,m))) then
                V1 := Jplus(D*N,m);
                else V1 := Jminus(D*N,m);
            end if;
            V := [a : a in  Decomposition(V1) | IsDivisibleBy(Conductor(a),D)];
            assert #V eq 1;
            r := RankBounds(EllipticCurve(V[1]));
            assert r in [0,1];
            if r eq 0 then rank0 := rank0 cat [[D,N,m]];
                else rank1 := rank1 cat [[D,N,m]];
            end if;
        end if;
    end for;
end for;


// generating list of genus 1 quotients with N not squarefree

for pair in not_sqfree_candidate_pairs do
    D := pair[1]; N := pair[2];
    for m in HallDivisors(D*N) do
        if quot_genus(D,N,m) eq 1 then
            Append(~genus_1_quotients_N_not_sqfree,[D,N,m]);
        end if;
    end for;
end for;


// SetOutputFile("genus_1_quotients_N_sqfree.m");
// print genus_1_quotients_N_sqfree;
// UnsetOutputFile();

// SetOutputFile("rank0.m");
// print rank0;
// UnsetOutputFile();

// SetOutputFile("rank1.m");
// print rank1;
// UnsetOutputFile();

// SetOutputFile("genus_1_quotients_N_not_sqfree.m");
// print genus_1_quotients_N_not_sqfree;
// UnsetOutputFile();

