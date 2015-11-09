(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-m.m"]


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        DI = SymbolicTensor`DumbIndex
    },
    
    {
        VerificationTest[
            SS[ a b[i_], SI[{i_, 2}] ],
            a SS[ b[DI[1]], SI[{DI[1], 2}] ],
            TestID -> "s-m -- etract constant"
        ],
        
        VerificationTest[
            SS[ a, SI[{i_, 2},{j_, 3}] ],
            6 a,
            TestID -> "s-m -- atom expression"
        ],
        
        VerificationTest[
            Hold @ Evaluate @ SS[ a[i_] b[i_,j_], SI[{i_},{j_}] ],
            Hold @ SS[ a[i_] b[i_,j_], SI[{i_},{j_}] ],
            TestID -> "s-m -- no simplification"
        ],
        
        VerificationTest[
            SS[ a[i_] b[i_,j_] c[k_], SI[{i_},{j_},{k_}] ],
            SS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                SS[c[DI[1]], SI[{DI[1]}]],
            TestID -> "s-m -- two groups"
        ],
        
        VerificationTest[
            SS[ a[i_] b[i_,j_] c[k_] d, SI[{i_},{j_},{k_}] ],
            SS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                SS[c[DI[1]], SI[{DI[1]}]] d,
            TestID -> "s-m -- free term w/o empty sum"
        ],
        
        VerificationTest[
            SS[ a[i_] b[i_,j_] c[k_], SI[{i_},{j_},{k_},{l_}] ],
            SS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                SS[c[DI[1]], SI[{DI[1]}]] SS[1, SI[{DI[1]}]],
            TestID -> "s-m -- irreducible empty sum w/o free term"
        ],
        
        VerificationTest[
            SS[ a[i_] b[i_,j_] c[k_] d, SI[{i_},{j_},{k_},{l_}] ],
            SS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                SS[c[DI[1]], SI[{DI[1]}]] SS[1, SI[{DI[1]}]] d,
            TestID -> "s-m -- irreducible empty sum + free term"
        ],
        
        VerificationTest[
            SS[ a[i_] b[i_,j_] c[k_] d, SI[{i_},{j_},{k_},{l_, 3}] ],
            SS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                SS[c[DI[1]], SI[{DI[1]}]] 3 d,
            TestID -> "s-m -- reducible empty sum + free term"
        ],
        
        VerificationTest[
            SS[ a[i_] b[i_,j_] c[k_] d, SI[{i_},{j_},{k_},{l_, 3},{m_,5}] ],
            SS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                SS[c[DI[1]], SI[{DI[1]}]] 15 d,
            TestID -> "s-m -- reducible empty sum + free term 2"
        ],
        
        VerificationTest[
            SS[ a[i_] c[k_] d, SI[{i_},{j_},{k_},{l_, 3}] ],
            SS[ a[DI[1]], SI[{DI[1]}] ]
                SS[c[DI[1]], SI[{DI[1]}]] 3 d SS[ 1, SI[{DI[1]}] ],
            TestID -> "s-m -- mixed empty sum + free term"
        ]
    }
]
