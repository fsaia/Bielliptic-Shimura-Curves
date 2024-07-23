// Here, we narrow our list of candidate geometrically trigonal pairs (D,N) with D,N > 1 and D,N relatively
// prime using the genus bound: if X_0^D(N) is geometrically trigonal, then g(X_0^D(N)) <= 29. 


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


// prod_bound : crude bound on DN for X_0^D(N) with genus <= 29
prod_bound := 21473;

// candidate_pairs : list of pairs (D,N) with D,N>1 and (D,N) = 1 so that X_0^D(N) is possible bielliptic, using possible values of D and fact
// that genus must be at most 39. This list ends up consisting of 350 pairs. 

candidate_pairs := [* *];

for D in [6..prod_bound] do
    F := Factorization(D);
    check := true;

    if IsOdd(#F) then
        check := false;

    else 
        for pair in F do
            if pair[2] ne 1 then
                check := false;
                break;
            end if;
        end for;
    end if;

    if check eq true then
    
        for N in [1..Floor(prod_bound/D)] do 
            if (Gcd(D,N) eq 1) and (genus(D,N) le 29) then 
                Append(~candidate_pairs,[D,N]);
            end if;
        end for;
    end if;
end for; 


// SetOutputFile("trigonal_candidate_pairs.m");
// print "trigonal_candidate_pairs := ";
// print candidate_pairs;
// print ";";
// UnsetOutputFile();







