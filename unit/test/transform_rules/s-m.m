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
            SS[ a[i_] b[i_,j_], SI[{i_},{j_}] ],
            SS[ a[i_] b[i_,j_], SI[{i_},{j_}] ],
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
            TestID -> "s-m -- empty sum w/o free term"
        ],
        
        VerificationTest[
            SS[ a[i_] b[i_,j_] c[k_] d, SI[{i_},{j_},{k_},{l_}] ],
            SS[ a[DI[1]] b[DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ]
                SS[c[DI[1]], SI[{DI[1]}]] SS[d, SI[{DI[1]}]],
            TestID -> "s-m -- empty sum + free term"
        ]
    }
]
