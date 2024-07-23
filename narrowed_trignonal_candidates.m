// narrowed_trigonal_candidates: list of all 6 relatively prime pairs (D,N) with D>1 
// with 
    // 2 <= g(X_0^D(N)) <= 29 (Abramovich bound required to be trigonal)
    // g(X_0^D(N)) not equal to 1 modulo 4 (Schweizer Corollary 3.5)
    // X_0^D(N) having the required fixed point counts for all Atkin--Lehner involutions (via Schweizer Lemma 3.4)

// Note: all of these are indeed geometrically trigonal except for the genus 8 curve (214,1)

narrowed_trigonal_candidates := 
[*
    [ 26, 1 ],
    [ 38, 1 ],
    [ 58, 1 ],
    [ 106, 1 ],
    [ 118, 1 ],
    [ 214, 1 ]
*];
