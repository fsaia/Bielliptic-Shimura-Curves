// In this code, we narrow down the pairs in trigonal_candidate_pairs.m using the two results of Schweizer 
// on geometrically trigonal curves. 

load "trigonal_candidate_pairs.m";
load "quot_genus.m";

// Given a positive integer N, returns the list of divisors d | n such that GCD(d,N/d) = 1.
HallDivisors := function(N)
    assert N ge 1;
    return [d : d in Divisors(N) | GCD(d,Integers()!(N/d)) eq 1];
end function;

narrowed_trigonal_candidates := [* *];


// removing pairs from candidates list based on Schweizer 15, Lemma 3.4: If X is trigonal, then
    // If g is odd, any involution has 4 fixed points
    // If g is even, any involution has 2 or 6 fixed points
// and then based on Schweizer 15, Corollary 3.5: 
        // If g(X) is 1 mod 4 and Aut(X) has a subgroup isomorphic to (Z/2Z)^2, then X
        // is not trigonal. Since D>1, this applies to any pairs with g(X) = 1 (mod 4).

for pair in trigonal_candidate_pairs do

    D := pair[1];
    N := pair[2];
    g := Integers()!genus(D,N);
    H := [d : d in HallDivisors(D*N) | d ne 1];

    count_check := true; 

    if IsOdd(g) then 

        for m in H do 

            if m eq 2 then 
                fixed_number := count_fixed_points(D,N,m,-4,1) + count_fixed_points(D,N,m,-8,1); 

            elif (m mod 4) eq 3 then 
                disc_K := -1*sqfree_part(m); // K = Q(sqrt(-m))
                _,f := IsSquare(Integers()!(m/sqfree_part(m)));
                fixed_number := count_fixed_points(D,N,m,disc_K,f) + count_fixed_points(D,N,m,disc_K,2*f);

            else
                disc_K := -4*(sqfree_part(m)); // K = Q(sqrt(-m))
                _,f := IsSquare(Integers()!(m/sqfree_part(m)));
                fixed_number := count_fixed_points(D,N,m,disc_K,f); 
            end if; 


            if fixed_number ne 4 then
                count_check := false;
                break; 
            end if;

        end for; 


    elif IsEven(g) then 
        for m in H do 
            if m eq 2 then 
                fixed_number := count_fixed_points(D,N,m,-4,1) + count_fixed_points(D,N,m,-8,1); 

            elif (m mod 4) eq 3 then 
                disc_K := -1*sqfree_part(m); // K = Q(sqrt(-m))
                _,f := IsSquare(Integers()!(m/sqfree_part(m)));
                fixed_number := count_fixed_points(D,N,m,disc_K,f) + count_fixed_points(D,N,m,disc_K,2*f);

            else
                disc_K := -4*(sqfree_part(m)); // K = Q(sqrt(-m))
                _,f := IsSquare(Integers()!(m/sqfree_part(m)));
                fixed_number := count_fixed_points(D,N,m,disc_K,f); 

            end if; 

            if not (fixed_number in [2,6]) then
                count_check := false; 
                break;
            end if;

        end for; 

    end if; 

    if (g ge 2) and ((count_check eq true) and ((g mod 4) ne 1)) then 
        Append(~narrowed_trigonal_candidates,pair);
    end if; 

end for; 


// SetOutputFile("narrowed_trignonal_candidates.m");
// print "narrowed_trigonal_candidates := ";
// print narrowed_trigonal_candidates;
// print ";"; 
// UnsetOutputFile();




