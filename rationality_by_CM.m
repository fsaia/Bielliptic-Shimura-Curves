// Here, we aim to prove that certain bielliptic quotients are bielliptic over Q by showing that the
// genus one quotient has a rational CM points. 

load "shimura_curve_CM_locus.m";
class_num_1 := cond_disc_list_allO[1]; // class number 1 im quad orders
class_num_2 := cond_disc_list_allO[2]; // class number 2 im quad orders

// list of pairs (D,N) for which we are not sure whether X_0^D(N) is bielliptic over Q
to_check := [[6,5],[6,7],[6,11],[6,13],[6,17],[6,19],[6,23],[6,41],[6,43],[6,47],[6,71],[10,3],[10,7],[10,13],[10,17],[10,29],[10,31],[14,3],[14,5],[14,13],[14,19],[15,2],[15,7],[15,11],[15,13],[15,17],[21,2],[21,5],[21,11],[22,3],[22,7],[22,17],[26,5],[33,2],[33,5],[33,7],[34,3],[35,2],[35,3],[38,3],[46,5]];

// for each pair in to_check, we list all of the quadratic CM points

to_check_quad_pts := [* *];
// format: an element of to_check_quad_pts is of form [* D, N, quad_pts *]
// where quad_pts is a sequence which consists of two sequences -- the second is for 
// points with residue field a ring class field, and the former for points with residue field
// a subfield of a ring class field cut out by an involution of a certain type. Each of these
// two sequences has elements of the form [d_K,f,f',number] where [f,d_K] is the order
// of the CM point, f' is the conductor corresponding to the residue field, and number is the number
// of points with that same residue field (and ramification index w.r.t. the map
// to trivial level, which we don't track here)

for pair in to_check do 
    D := pair[1];
    N := pair[2];

    quad_pts := [*[**],[**]*]; 
    for order in class_num_1 do
        pts := CM_points_XD0(D,order[1],order[2],N);

        if Type(pts) ne MonStgElt then 

            for pt in pts[1] do 
                if pt[3] eq 2 then 
                    Append(~quad_pts[1],[order[2],order[1],pt[1],pt[4]]);
                end if;
            end for;

            for pt in pts[2] do 
                if pt[3] eq 2 then 
                    Append(~quad_pts[2],[order[2],order[1],pt[1],pt[4]]);
                end if;
            end for;
        end if; 
    end for; 

    Append(~to_check_quad_pts, [* D, N, quad_pts *]); 
end for;


// SetOutputFile("to_check_quad_pts.m");
// print to_check_quad_pts;
// UnsetOutputFile();



// quotients_to_check : list of sequences [*D, N, m_list*] where m_list is the list 
// of values of m dividing DN for which X_0(D,N)/w_m is genus 1 

quotients_to_check := [* [* 6, 5, [*3,5,15 *] *], 
    [* 6, 7, [* 2, 7,14 *] *], 
    [* 6, 11, [* 6, 22, 33 *] *],
    [* 6, 13, [* 6, 26,39*] *], 
    [* 6, 17, [* 2, 51, 102 *] *],
    [* 6, 19, [* 3, 19, 57 *] *],
    [* 6, 23, [* 46, 69, 138 *] *], 
    [* 6, 41, [* 246 *] *], 
    [* 6, 43, [* 129 *] *], 
    [* 6, 47, [* 94 *] *], 
    [* 6, 71, [* 426 *] *], 
    [* 10, 3, [* 6, 10, 15 *] *], 
    [* 10, 7, [* 2, 7, 14 *] *], 
    [* 10, 13, [* 10, 13, 130 *] *],
    [* 10, 17, [* 170 *] *], 
    [* 10, 29, [* 290 *] *], 
    [* 10, 31, [* 62 *] *], 
    [* 14, 3, [* 2, 21, 42 *] *],
    [* 14, 5, [* 2, 35, 70*] *], 
    [* 14, 13, [* 182 *] *], 
    [* 14, 19, [* 266 *] *], 
    [* 15, 2, [* 10, 30 *] *],
    [* 15, 7, [* 3, 7, 105 *] *], 
    [* 15, 11, [* 55 *] *], 
    [* 15, 13, [* 195 *] *], 
    [* 15, 17, [* 255 *] *], 
    [* 21, 2, [* 2, 21, 42 *] *],
    [* 21, 5, [* 15, 21, 105 *] *],
    [* 21, 11, [* 231 *] *],
    [* 22, 3, [* 3, 11, 33 *] *], 
    [* 22, 7, [* 14, 77, 154 *] *], 
    [* 22, 17, [* 374 *] *], 
    [* 26, 5, [* 26 *] *],
    [* 33, 2, [* 66 *] *], 
    [* 33, 5, [* 55 *] *], 
    [* 33, 7, [* 231 *] *], 
    [* 34, 3, [* 17 *] *], 
    [* 35, 2, [* 35 *] *],
    [* 35, 3, [* 35 *] *],
    [* 38, 3, [* 38 *] *], 
    [* 46, 5, [* 230 *] *] *];


// reminder : pt info lists in to_check_quad_pts are in order [d_K,f,f',number]
// where f is the CM cnductor for the point, and f' is for its residue field

// quad_image_info : list of information about the images of quadratic points in to_check_quad_pts
// on certain Atkin--Lehner quotients. In particular, using GR06 Corollary 5.14, we record for given
// D,N,m, and point list corresponding to [D,N] in to_check_quad_pts whether points of that residue
// field are fixed by w_m
// structure: sequence of sequences [* D, N, pts_info *] where pts_info, where pts_info
// is a sequence of sequences of the form [* m, pts_1, pts_2 *] where pts_i includes, for every quad_pts
// list corresponding to [D,N] in to_check_quad_pts, a sequence [d_K,f,f',B] where B is True if f^2d_K
// points in that list have rational image on X_0^D(N)/w_M and False otherwise. i=1 corresponds to points
// on X_0^D(N) with res fld an index 2 subfield of K(f'), while pts_2 corresponds to points with
// res fld K(f'). 

quad_image_info := [* *];

for i in [1..#quotients_to_check] do 
    D := quotients_to_check[i][1];
    N := quotients_to_check[i][2];
    pts_1 := to_check_quad_pts[i][3][1]; // quad CM pts on X_0^D(N) w/ res fld index 2 in K(f') as in GR06
    pts_2 := to_check_quad_pts[i][3][2]; // quad CM pts on X_0^D(N) w/ res fld K(f') 

    Append(~quad_image_info, [* D, N , [* *] *]);

    for m_index in [1..#quotients_to_check[i][3]] do

        m := quotients_to_check[i][3][m_index];

        Append(~quad_image_info[i][3], [* m, [ ], [ ] *]);

        for pt in pts_1 do // GR06 Cor 5.14 (2)
            d_K := pt[1];
            f_R := pt[3];
            disc_R := f_R^2*d_K;
            m_r := GCD(IntegerRing()!m,IntegerRing()!(disc_R/GCD(N,f_R)));
            Q := m/m_r;

            D_R := 1;
            for pair in Factorization(D) do
                if ((f_R mod pair[1]) ne 0) and (KroneckerSymbol(disc_R,pair[1]) eq -1) then
                    D_R := D_R*pair[1];
                end if;
            end for;

            N_star_R := 1;
            for pair in Factorization(N) do 
                if (KroneckerSymbol(disc_R,pair[1]) eq 1) and ((f_R mod pair[1]) ne 0) then
                    N_star_R := N_star_R*pair[1];
                end if;
            end for; 

            // Now we use GRO6 Cor. 5.14 (2) to determine rationality of image points
            // note: d_R in {-12,-16,-27} give false info, as these aren't the correct
            // orders to attach in GR06's framework. We lose nothing by ignoring these orders,
            // as if we actually have fixed points of these orders we have fixed points of 
            // order -3 or -4.
            if (Q eq 1) and (not (D_R in [-12,-16,-27])) then 
                Append(~quad_image_info[i][3][m_index][2],[* d_K,pt[2],f_R,pt[4],"True" *]);
            else
                Append(~quad_image_info[i][3][m_index][2],[* d_K,pt[2],f_R,pt[4],"False" *]);
            end if; 
        end for;

        for pt in pts_2 do // GR06 Cor 5.14 (1)
            d_K := pt[1];
            f_R := pt[3];
            disc_R := f_R^2*d_K;
            m_r := GCD(IntegerRing()!m,IntegerRing()!(disc_R/GCD(N,f_R)));
            Q := m/m_r;

            D_R := 1;
            for pair in Factorization(D) do
                if ((f_R mod pair[1]) ne 0) and (KroneckerSymbol(disc_R,pair[1]) eq -1) then
                    D_R := D_R*pair[1];
                end if;
            end for;

            N_star_R := 1;
            for pair in Factorization(N) do 
                if (KroneckerSymbol(disc_R,pair[1]) eq 1) and ((f_R mod pair[1]) ne 0) then
                    N_star_R := N_star_R*pair[1];
                end if;
            end for; 

            // Now we use GRO6 Cor. 5.14 (1) to determine rationality of image points
            // note: d_R in {-12,-16,-27} give false info, as these aren't the correct
            // orders to attach in GR06's framework. We lose nothing by ignoring these orders,
            // as if we actually have fixed points of these orders we have fixed points of 
            // order -3 or -4.
            if (Q eq D_R*N_star_R) and (not (disc_R in [-12,-16,-27])) then
                Append(~quad_image_info[i][3][m_index][3],[* d_K,pt[2],f_R,pt[4],"True" *]);
            else
                Append(~quad_image_info[i][3][m_index][3],[* d_K,pt[2],f_R,pt[4],"False" *]);
            end if; 
        end for;
    end for;
end for; 


// outputs list of elliptic quotients on which there is a rational CM point

rational_CM_pts_info := [* *];

for i in [1..#quad_image_info] do
    D := quad_image_info[i][1];
    N := quad_image_info[i][2];
    Append(~rational_CM_pts_info, [* D, N, [ ] *]);
    for m_index in [1..#quad_image_info[i][3]] do

        m := quad_image_info[i][3][m_index][1];

        found_rat := "False";

        for pt in quad_image_info[i][3][m_index][2] do
            if pt[5] eq "True" then
                found_rat := "True";
                break;
            end if;
        end for;

        if found_rat eq "False" then

            for pt in quad_image_info[i][3][m_index][3] do
                if pt[5] eq "True" then
                    found_rat := "True";
                    break;
                end if;
            end for;

        end if;

        if found_rat eq "True" then 
            Append(~rational_CM_pts_info[i][3], m);
        end if; 
    end for;
end for;


// SetOutputFile("rational_CM_pts_info.m");
// print "quad_image_info := ", quad_image_info;
// print "rational_CM_pts_info := ", rational_CM_pts_info;
// UnsetOutputFile(); 

