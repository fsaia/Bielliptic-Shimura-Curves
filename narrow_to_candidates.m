// Here, we narrow our list of candidate bielliptic pairs (D,N) with D,N > 1 and D,N relatively
// prime using the genus bound: if X_0^D(N) is bielliptic, then g(X_0^D(N)) <= 39, and the 
// fact that if X_0^D(N) is bielliptic then X_0^D(1) is bielliptic, hyperelliptic, or of
// genus at most 1. We then prove that certain candidate pairs have Aut(X_0^D(N)) = W_0(D,N)


// phi_from_fact: Given natural N, factorization of N (list of pairs (p,a)), computes phi(N) 

phi_from_fact := function(N,F)
    P := N;
    for i in [1..#F] do
        P := P*(1-1/(F[i][1]));
    end for;
    return P;
end function;



// psi_from_fact: Given natural N, factorization of N (list of pairs (p,a)), computes psi(N)

psi_from_fact := function(N,F)
    M := 1;
        for i in [1..#F] do
            M := M * (F[i][1]+1)*F[i][1]^(F[i][2]-1);
        end for;
    return M;
end function;



// e1_from_fact: Given factorizations F_D and F_N of a rational quaternion discriminant D and
// a natural number N which is coprime to D, respectively, returns e_1(D,N)

e1_from_facts := function(F_D,F_N,N)
    if (N mod 4) eq 0 then
        return 0;
    else
        P := 1;
        for i in [1..#F_D] do
            P := P*(1-KroneckerSymbol(-4,F_D[i][1]));
        end for;
        for i in [1..#F_N] do
            P := P*(1+KroneckerSymbol(-4,F_N[i][1]));
        end for;
        return P;
    end if; 
end function;



// e3_from_fact: Given factorizations F_D and F_N of a rational quaternion discriminant D and
// a natural number N which is coprime to D, respectively, returns e_3(D,N)

e3_from_facts := function(F_D,F_N,N)
    if (N mod 9) eq 0 then
        return 0;
    else
        P := 1;
        for i in [1..#F_D] do
            P := P*(1-KroneckerSymbol(-3,F_D[i][1]));
        end for;
        for i in [1..#F_N] do
            P := P*(1+KroneckerSymbol(-3,F_N[i][1]));
        end for;
        return P;
    end if; 
end function;


// genus

genus := function(D,N)
    FD := Factorization(D);
    FN := Factorization(N);
    return (1+phi_from_fact(D,FD)*psi_from_fact(N,FN)/12 - e1_from_facts(FD,FN,N)/4 - e3_from_facts(FD,FN,N)/3);
end function; 


// possible_D_list : list of indefinite rational quaternion discriminants D such that X_0^D(1) has genus at most 1 or is hyperelliptic or bielliptic

possible_D_list := [6,10,14,15,21,22,26,33,34,35,38,39,46,51,55,57,58,62,65,69,74,77, 82,86,87,94,95,106,111,118,119,122,129,134,143,146,159,166,194,206,210,215,314,330,390,510,546];


// prod_bound : crude bound on DN for X_0^D(N) with genus <= 39
prod_bound := 78530;

// candidate_pairs : list of pairs (D,N) with D,N>1 and (D,N) = 1 so that X_0^D(N) is possible bielliptic, using possible values of D and fact
// that genus must be at most 39. This list ends up consisting of 350 pairs. 

candidate_pairs := [* *];

for D in possible_D_list do 
    for N in [2..Floor(prod_bound/D)] do 
        if (Gcd(D,N) eq 1) and (genus(D,N) le 39) then 
            Append(~candidate_pairs,[D,N]);
        end if;
    end for;
end for; 


// SetOutputFile("candidate_pairs.m");
// print candidate_pairs;
// UnsetOutputFile();




// we check that the full automorphism group is the Atkin--Lehner group using
    // Rotger 2002 Theorem 2 (true if we have no elliptic points for sqfree level N)
    // Kontogeorgis--Rotger 2008 Theorems 1.6 and 1.7 and Corollaries

// all_atkin_lehner : list of candidate pairs for which we know that full automorphism
// group is the Atkin--Lehner group W_0(D,N)

all_atkin_lehner := [];

for pair in candidate_pairs do
    D := pair[1];
    N := pair[2];
    F_D := Factorization(D);
    F_N := Factorization(N);
    g := IntegerRing()!genus(D,N);
    r := #F_D + #F_N; // r = omega(DN)
    if IsSquarefree(N) then
        e_1 := e1_from_facts(F_D,F_N,N);
        e_3 := e3_from_facts(F_D,F_N,N);

        if (D*N mod 2) eq 0 then // using full strength of KR Thm 1.7 (i) with m=2
            
            check_2 := true; // check on prime divisors of N

            for factor in Factorization(N) do
                p := factor[1];
                if (KroneckerSymbol(-4,p) eq -1) then
                    check_2 := false;
                end if;
            end for;

            if check_2 eq true then // then we check factors of D
                c := 0;
                for factor in Factorization(D) do
                    p := factor[1];
                    if (KroneckerSymbol(-4,p) eq 1) then
                        c := c+1;
                    end if; 
                end for; 

                if (c le 1) then 
                    Append(~all_atkin_lehner, pair); 
                end if;
            end if;
        end if; 

        if (D*N mod 3) eq 0 then // using full strength of KR Thm 1.7 (i) with m=3
            
            check_3 := true; // check on prime divisors of N

            for factor in Factorization(N) do
                p := factor[1];
                if (KroneckerSymbol(-3,p) eq -1) then
                    check_3 := false;
                end if;
            end for;

            if check_3 eq true then // then we check factors of D
                c := 0;
                for factor in Factorization(D) do
                    p := factor[1];
                    if (KroneckerSymbol(-3,p) eq 1) then
                        c := c+1;
                    end if; 
                end for; 

                if (c le 1) and (not (pair in all_atkin_lehner)) then 
                    Append(~all_atkin_lehner, pair); 
                end if;
            end if;
        end if; 

            
        // if previous didn't work, try 1.6 i and 1.6 ii and Lemma arguments
        if not (pair in all_atkin_lehner) then
            if (((e_1 eq 0) and (e_3 eq 0))) or (r eq Valuation(g-1,2)+2) or ((g mod 2 eq 0) and (r eq 3))  or ((g mod 2 eq 1) and (r eq 4)) then
                Append(~all_atkin_lehner,pair);
            end if; 
        end if;

    end if;
end for;


// SetOutputFile("all_atkin_lehner.m");
// print all_atkin_lehner;
// UnsetOutputFile();




