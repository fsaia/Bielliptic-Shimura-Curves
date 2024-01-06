# Bielliptic-Shimura-Curves
Magma code for the paper *Bielliptic Shimura curves* $X_0^D(N)$ *with nontrivial level* by Oana Padurariu and Frederick Saia. The contents, sorted roughly in order of use in the paper, are as follows: 


## Main Files

- `narrow_to_candidates.m`: Here, we narrow our list of candidate bielliptic pairs $(D,N)$ with $D,N > 1$ and $D,N$ relatively prime using the genus bound: if $X_0^D(N)$ is bielliptic, then $g(X_0^D(N)) \leq 39$, and the fact that if $X_0^D(N)$ is bielliptic then $X_0^D(1)$ is bielliptic, hyperelliptic, or of genus at most $1$. We then prove that certain candidate pairs have $\text{Aut}(X_0^D(N)) = W_0(D,N)$. 

- `quot_genus.m`: The main function, quot_genus, computes for a given indefinite rational quaternion discriminant $D$, positive integer $N$ coprime to $D$, and $m \parallel DN$, the genus of the quotient Shimura curve $X_0^D(N)/\langle w_m \rangle$.

- `rationality_by_CM.m`: Here, we aim to prove that certain bielliptic quotients are bielliptic over $\mathbb{Q}$ by showing that the genus one quotient has a rational CM point. 

- TO FILL IN: rank computations, etc. 

- `narrow_sporadics.m`: The aim of this code is to use our results on Bielliptic Shimura curves $X_0^D(N)$ to decrease the number of pairs $(D,N)$ for which we remain unsure of whether $X_0^D(N)$ has a sporadic point, following initial work of Saia 2023. 


## Required Files

- `cond_disc_list_allO.m`: list of all (not just maximal) imaginary quadratic orders of class number up to $100$. The $i^\text{th}$ element is the complete list of sequences $[f,d_K] = [\text{conductor}, \text{fundamental disc}]$ for imaginary quadratic orders of class number $i$. Generated using list of maximal orders by M. Watkins. This list is used in least degree computations in `shimura_curve_CM_locus.m`.

- `shimura_curve_CM_locus.m`: The aim of this code, from the paper *CM points on Shimura curves via QM-equivariant isogeny volcanoes* (Saia 2023)  is to compute the $\Delta$-CM locus on $X_0^D(N)$ for any imaginary quadratic discriminant $\Delta$ and positive integer $N$ coprime to a given quaternion discriminant $D$. This is done via the QM-equivariant isogeny volcano approach of the referenced paper of Saia in the $D>1$ case, and of work of Clark--Saia in the $D=1$ case. In particular, this file contains code to enumerate all CM points of a specified discriminant Delta with all possible residue fields up to isomorphism for one of these Shimura curves. This is used in quadratic CM point computations in `rationality_by_CM` and least degrees of CM points computations in `narrow_sporadics.m`.

- `unknown_sporadics.m`: List of all $391$ triples $[D,N,d_\text{CM}(X_0^D(N))]$ consisting of pairs $[D,N]$ for which we are unsure whether $X_0^D(N)$ has a sporadic CM point following work of Saia 2023. This list is used in `narrow_sporadics.m`, where we try to improve on the results of Saia 2023 by decreasing the number of unknowns. 


## Computed Lists 

- `all_atkin_lehner.m`: list of $269$ candidate pairs $(D,N)$ for which we know that full automorphism group of $X_0^D(N)$ is the Atkin--Lehner group $W_0(D,N)$. This is computed in the file `narrow_to_candidates.m`.

- `candidate_pairs.m`: list of $350$ pairs $(D,N)$ with $D,N>1$ and $(D,N) = 1$ so that $X_0^D(N)$ is possible bielliptic, given that $X_0^D(1)$ is of genus at most $2$ or is hyperelliptic or bielliptic and that $g(X_0^D(N))$ is at most $39$. This is computed in the file `narrow_to_candidates.m`.

- `sqfree_candidate_pairs.m` : list of $295$ pairs $(D,N)$ from `candidate_pairs.m` with $N$ squarefree.

- `not_sqfree_candidate_pairs.m` : list of $55$ pairs $(D,N)$ from `candidate_pairs.m` with $N$ not squarefree.

- `to_check_quad_pts.m`: for all the pairs $(D,N)$ for which we are unsure whether $X_0^D(N)$ is bielliptic over $\mathbb{Q}$ (via an Atkin--Lehner involution), we list all of the quadratic CM points on $X_0^D(N)$. This is computed in `rationality_by_CM.m`.

- `rational_CM_pts_info.m`: info on rational CM points on genus $1$ Atkin--Lehner quotients $X_0^D(N)/\langle w_m \rangle$, computed in `rationality_by_CM.m`. 

- `has_sporadic_CM_X0.m`: list of $306$ pairs $[D,N]$ for which we know $X_0^D(N)$ has a sporadic CM point, by virtue of having a degree $2$ CM point and not having infinitely many deg $2$ points. This is computed in `narrow_sporadics.m`.

- `has_sporadic_CM_X1.m`: list of $75$ pairs $[D,N]$ for which we know $X_1^D(N)$ has a sporadic CM point, by virtue of having a degree $2$ CM point and not having infinitely many deg $2$ points. This is computed in `narrow_sporadics.m`.

- `new_no_sporadics_XD0.m`: list of all $73$ pairs $[D,N]$ for which we know that $X_0^D(N)$ has no sporadic points, by virtue of having infinitely many degree $2$ points. This list includes (all but at most $3$) cases where $X_0^D(N)$ is bielliptic with a bielliptic quotient of positive rank over $\mathbb{Q}$. This is computed in `narrow_sporadics.m`.

- `no_sporadic_CM_X1.m`: list of $4$ pairs $[D,N]$ for which we determine that $X_1^D(N)$ has no sporadic CM points, by virtue of $X_0^D(N)$ having infinitely many degree $2$ points and having $\text{a.irr}_{\mathbb{Q}}(X_1^D(N)) \leq$ $\text{max}(2,\phi(N)) \leq d_{\text{CM}}(X_1^D(N))$. This is computed in `narrow_sporadics.m`.

- `new_unknowns_X0.m`: narrowed list of $76$ triples $[D,N,d_\text{CM}(X_0^D(N))]$, where $[D,N]$ is such that we remain unsure whether $X_0^D(N)$ has a sporadic point. This is computed in `narrow_sporadics.m`.

- `new_unknowns_X1.m`: narrowed list of $323$ triples $[D,N,d_\text{CM}(X_1^D(N))]$, where $[D,N]$ is such that we remain unsure whether $X_1^D(N)$ has a sporadic point. This is computed in `narrow_sporadics.m`.


