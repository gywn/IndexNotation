(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-m.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IS[ a b[i], SI[{i, 2}] ],
            a IS[ b[DI[1]], SI[{DI[1], 2}] ],
            TestID -> "s-m -- etract constant"
        ],
        
        VerificationTest[
            IS[ a, SI[{i, 2},{j, 3}] ],
            6 a,
            TestID -> "s-m -- atom expression"
        ],
        
        VerificationTest[
            Hold @ Evaluate @ IS[ a[i] b[i,j], SI[{i},{j}] ],
            Hold @ IS[ a[i] b[i,j], SI[{i},{j}] ],
            TestID -> "s-m -- no simplification"
        ],
        
        VerificationTest[
            IS[ a[i] b[i,j] c[k], SI[{i},{j},{k}] ],
            IS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                IS[c[DI[1]], SI[{DI[1]}]],
            TestID -> "s-m -- two groups"
        ],
        
        VerificationTest[
            IS[ a[i] b[i,j] c[k] d, SI[{i},{j},{k}] ],
            IS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                IS[c[DI[1]], SI[{DI[1]}]] d,
            TestID -> "s-m -- free term w/o empty sum"
        ],
        
        VerificationTest[
            IS[ a[i] b[i,j] c[k], SI[{i},{j},{k},{l}] ],
            IS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                IS[c[DI[1]], SI[{DI[1]}]] IS[1, SI[{DI[1]}]],
            TestID -> "s-m -- irreducible empty sum w/o free term"
        ],
        
        VerificationTest[
            IS[ a[i] b[i,j] c[k] d, SI[{i},{j},{k},{l}] ],
            IS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                IS[c[DI[1]], SI[{DI[1]}]] IS[1, SI[{DI[1]}]] d,
            TestID -> "s-m -- irreducible empty sum + free term"
        ],
        
        VerificationTest[
            IS[ a[i] b[i,j] c[k] d, SI[{i},{j},{k},{l, 3}] ],
            IS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                IS[c[DI[1]], SI[{DI[1]}]] 3 d,
            TestID -> "s-m -- reducible empty sum + free term"
        ],
        
        VerificationTest[
            IS[ a[i] b[i,j] c[k] d, SI[{i},{j},{k},{l, 3},{m,5}] ],
            IS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                IS[c[DI[1]], SI[{DI[1]}]] 15 d,
            TestID -> "s-m -- reducible empty sum + free term 2"
        ],
        
        VerificationTest[
            IS[ a[i] c[k] d, SI[{i},{j},{k},{l, 3}] ],
            IS[ a[DI[1]], SI[{DI[1]}] ]
                IS[c[DI[1]], SI[{DI[1]}]] 3 d IS[ 1, SI[{DI[1]}] ],
            TestID -> "s-m -- mixed empty sum + free term"
        ]
    }
]


End[];
