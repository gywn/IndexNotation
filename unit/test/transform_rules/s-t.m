(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-t.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        DI = SymbolicTensor`DumbIndex        
    },
    
    {
        VerificationTest[
            SS[ ST[ a[j_,i_], TI[{j_}] ], SI[{i_}] ],
            ST[ SS[ a[DI[2],DI[1]], SI[{DI[1]}] ], TI[{DI[2]}] ],
            TestID -> "simple 1"
        ],
        
        VerificationTest[
            SS[ ST[ a[DI[4],DI[3],DI[2],DI[1]], TI[{DI[4]},{DI[3]}] ], SI[{DI[1]},{DI[2]}] ],
            ST[ SS[ a[DI[4],DI[3],DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ], TI[{DI[4]},{DI[3]}] ],
            TestID -> "simple 2"
        ],
        
        VerificationTest[
            SS[ ST[ a[DI[1]], TI[{DI[1]}] ], SI[{DI[1]}] ],
            ST[ SS[ a[DI[2]], SI[{DI[1]}] ], TI[{DI[2]}] ],
            TestID -> "shadowing"
        ]
    }
]
