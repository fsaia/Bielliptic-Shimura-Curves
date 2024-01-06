// candidate_pairs : list of 350 pairs (D,N) with D,N>1 and (D,N) = 1 so that X_0^D(N) 
// is possible bielliptic, given that X_0^D(1) is of genus at most 2 or is hyperelliptic or bielliptic
// and that g(X_0^D(N)) is at most 39. 

candidate_pairs := [*
    [ 6, 5 ],
    [ 6, 7 ],
    [ 6, 11 ],
    [ 6, 13 ],
    [ 6, 17 ],
    [ 6, 19 ],
    [ 6, 23 ],
    [ 6, 25 ],
    [ 6, 29 ],
    [ 6, 31 ],
    [ 6, 35 ],
    [ 6, 37 ],
    [ 6, 41 ],
    [ 6, 43 ],
    [ 6, 47 ],
    [ 6, 49 ],
    [ 6, 53 ],
    [ 6, 55 ],
    [ 6, 59 ],
    [ 6, 61 ],
    [ 6, 65 ],
    [ 6, 67 ],
    [ 6, 71 ],
    [ 6, 73 ],
    [ 6, 77 ],
    [ 6, 79 ],
    [ 6, 83 ],
    [ 6, 85 ],
    [ 6, 89 ],
    [ 6, 91 ],
    [ 6, 95 ],
    [ 6, 97 ],
    [ 6, 101 ],
    [ 6, 103 ],
    [ 6, 107 ],
    [ 6, 109 ],
    [ 6, 113 ],
    [ 6, 115 ],
    [ 6, 119 ],
    [ 6, 121 ],
    [ 6, 125 ],
    [ 6, 127 ],
    [ 6, 131 ],
    [ 6, 133 ],
    [ 6, 137 ],
    [ 6, 139 ],
    [ 6, 143 ],
    [ 6, 145 ],
    [ 6, 149 ],
    [ 6, 151 ],
    [ 6, 155 ],
    [ 6, 157 ],
    [ 6, 161 ],
    [ 6, 163 ],
    [ 6, 167 ],
    [ 6, 169 ],
    [ 6, 173 ],
    [ 6, 179 ],
    [ 6, 181 ],
    [ 6, 185 ],
    [ 6, 187 ],
    [ 6, 191 ],
    [ 6, 193 ],
    [ 6, 197 ],
    [ 6, 199 ],
    [ 6, 211 ],
    [ 6, 223 ],
    [ 6, 227 ],
    [ 6, 229 ],
    [ 6, 233 ],
    [ 6, 241 ],
    [ 10, 3 ],
    [ 10, 7 ],
    [ 10, 9 ],
    [ 10, 11 ],
    [ 10, 13 ],
    [ 10, 17 ],
    [ 10, 19 ],
    [ 10, 21 ],
    [ 10, 23 ],
    [ 10, 27 ],
    [ 10, 29 ],
    [ 10, 31 ],
    [ 10, 33 ],
    [ 10, 37 ],
    [ 10, 39 ],
    [ 10, 41 ],
    [ 10, 43 ],
    [ 10, 47 ],
    [ 10, 49 ],
    [ 10, 51 ],
    [ 10, 53 ],
    [ 10, 57 ],
    [ 10, 59 ],
    [ 10, 61 ],
    [ 10, 63 ],
    [ 10, 67 ],
    [ 10, 69 ],
    [ 10, 71 ],
    [ 10, 73 ],
    [ 10, 77 ],
    [ 10, 79 ],
    [ 10, 81 ],
    [ 10, 83 ],
    [ 10, 89 ],
    [ 10, 91 ],
    [ 10, 97 ],
    [ 10, 101 ],
    [ 10, 103 ],
    [ 10, 107 ],
    [ 10, 109 ],
    [ 10, 113 ],
    [ 14, 3 ],
    [ 14, 5 ],
    [ 14, 9 ],
    [ 14, 11 ],
    [ 14, 13 ],
    [ 14, 15 ],
    [ 14, 17 ],
    [ 14, 19 ],
    [ 14, 23 ],
    [ 14, 25 ],
    [ 14, 27 ],
    [ 14, 29 ],
    [ 14, 31 ],
    [ 14, 33 ],
    [ 14, 37 ],
    [ 14, 39 ],
    [ 14, 41 ],
    [ 14, 43 ],
    [ 14, 45 ],
    [ 14, 47 ],
    [ 14, 51 ],
    [ 14, 53 ],
    [ 14, 55 ],
    [ 14, 59 ],
    [ 14, 61 ],
    [ 14, 67 ],
    [ 14, 71 ],
    [ 14, 73 ],
    [ 15, 2 ],
    [ 15, 4 ],
    [ 15, 7 ],
    [ 15, 8 ],
    [ 15, 11 ],
    [ 15, 13 ],
    [ 15, 14 ],
    [ 15, 16 ],
    [ 15, 17 ],
    [ 15, 19 ],
    [ 15, 22 ],
    [ 15, 23 ],
    [ 15, 26 ],
    [ 15, 28 ],
    [ 15, 29 ],
    [ 15, 31 ],
    [ 15, 32 ],
    [ 15, 34 ],
    [ 15, 37 ],
    [ 15, 41 ],
    [ 15, 43 ],
    [ 15, 47 ],
    [ 15, 49 ],
    [ 15, 53 ],
    [ 21, 2 ],
    [ 21, 4 ],
    [ 21, 5 ],
    [ 21, 8 ],
    [ 21, 10 ],
    [ 21, 11 ],
    [ 21, 13 ],
    [ 21, 16 ],
    [ 21, 17 ],
    [ 21, 19 ],
    [ 21, 20 ],
    [ 21, 22 ],
    [ 21, 23 ],
    [ 21, 25 ],
    [ 21, 29 ],
    [ 21, 31 ],
    [ 21, 37 ],
    [ 22, 3 ],
    [ 22, 5 ],
    [ 22, 7 ],
    [ 22, 9 ],
    [ 22, 13 ],
    [ 22, 15 ],
    [ 22, 17 ],
    [ 22, 19 ],
    [ 22, 21 ],
    [ 22, 23 ],
    [ 22, 25 ],
    [ 22, 27 ],
    [ 22, 29 ],
    [ 22, 31 ],
    [ 22, 37 ],
    [ 22, 41 ],
    [ 22, 43 ],
    [ 26, 3 ],
    [ 26, 5 ],
    [ 26, 7 ],
    [ 26, 9 ],
    [ 26, 11 ],
    [ 26, 15 ],
    [ 26, 17 ],
    [ 26, 19 ],
    [ 26, 21 ],
    [ 26, 23 ],
    [ 26, 25 ],
    [ 26, 27 ],
    [ 26, 29 ],
    [ 26, 31 ],
    [ 26, 37 ],
    [ 33, 2 ],
    [ 33, 4 ],
    [ 33, 5 ],
    [ 33, 7 ],
    [ 33, 8 ],
    [ 33, 10 ],
    [ 33, 13 ],
    [ 33, 17 ],
    [ 33, 19 ],
    [ 34, 3 ],
    [ 34, 5 ],
    [ 34, 7 ],
    [ 34, 9 ],
    [ 34, 11 ],
    [ 34, 13 ],
    [ 34, 15 ],
    [ 34, 19 ],
    [ 34, 23 ],
    [ 35, 2 ],
    [ 35, 3 ],
    [ 35, 4 ],
    [ 35, 6 ],
    [ 35, 8 ],
    [ 35, 9 ],
    [ 35, 11 ],
    [ 35, 13 ],
    [ 35, 17 ],
    [ 38, 3 ],
    [ 38, 5 ],
    [ 38, 7 ],
    [ 38, 9 ],
    [ 38, 11 ],
    [ 38, 13 ],
    [ 38, 15 ],
    [ 38, 17 ],
    [ 38, 23 ],
    [ 39, 2 ],
    [ 39, 4 ],
    [ 39, 5 ],
    [ 39, 7 ],
    [ 39, 8 ],
    [ 39, 10 ],
    [ 39, 11 ],
    [ 39, 17 ],
    [ 46, 3 ],
    [ 46, 5 ],
    [ 46, 7 ],
    [ 46, 9 ],
    [ 46, 11 ],
    [ 46, 13 ],
    [ 46, 17 ],
    [ 46, 19 ],
    [ 51, 2 ],
    [ 51, 4 ],
    [ 51, 5 ],
    [ 51, 7 ],
    [ 51, 8 ],
    [ 51, 11 ],
    [ 51, 13 ],
    [ 55, 2 ],
    [ 55, 3 ],
    [ 55, 4 ],
    [ 55, 7 ],
    [ 57, 2 ],
    [ 57, 4 ],
    [ 57, 5 ],
    [ 57, 7 ],
    [ 57, 8 ],
    [ 57, 11 ],
    [ 58, 3 ],
    [ 58, 5 ],
    [ 58, 7 ],
    [ 58, 9 ],
    [ 58, 11 ],
    [ 58, 13 ],
    [ 62, 3 ],
    [ 62, 5 ],
    [ 62, 7 ],
    [ 62, 9 ],
    [ 62, 11 ],
    [ 62, 13 ],
    [ 65, 2 ],
    [ 65, 3 ],
    [ 65, 4 ],
    [ 65, 7 ],
    [ 69, 2 ],
    [ 69, 4 ],
    [ 69, 5 ],
    [ 69, 7 ],
    [ 74, 3 ],
    [ 74, 5 ],
    [ 74, 7 ],
    [ 74, 9 ],
    [ 74, 11 ],
    [ 77, 2 ],
    [ 77, 3 ],
    [ 77, 4 ],
    [ 77, 5 ],
    [ 82, 3 ],
    [ 82, 5 ],
    [ 82, 7 ],
    [ 86, 3 ],
    [ 86, 5 ],
    [ 86, 7 ],
    [ 87, 2 ],
    [ 87, 4 ],
    [ 87, 5 ],
    [ 87, 7 ],
    [ 94, 3 ],
    [ 94, 5 ],
    [ 94, 7 ],
    [ 95, 2 ],
    [ 95, 3 ],
    [ 95, 4 ],
    [ 106, 3 ],
    [ 106, 5 ],
    [ 106, 7 ],
    [ 111, 2 ],
    [ 111, 4 ],
    [ 111, 5 ],
    [ 118, 3 ],
    [ 118, 5 ],
    [ 118, 7 ],
    [ 119, 2 ],
    [ 119, 3 ],
    [ 122, 3 ],
    [ 122, 5 ],
    [ 129, 2 ],
    [ 134, 3 ],
    [ 134, 5 ],
    [ 143, 2 ],
    [ 146, 3 ],
    [ 146, 5 ],
    [ 159, 2 ],
    [ 166, 3 ],
    [ 194, 3 ],
    [ 206, 3 ]
*];
