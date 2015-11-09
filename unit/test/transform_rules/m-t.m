(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/m-t.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        DI = SymbolicTensor`DumbIndex        
    },
    
    {
        VerificationTest[
            ST[ a[i_, DI[2]], TI[{DI[2]},{i_}] ] DI[2] Sin[DI[1]],
            ST[ a[DI[3],DI[4]] DI[2] Sin[DI[1]], TI[{DI[4]},{DI[3]}] ],
            TestID -> "forced internal dumb index change"
        ],
        
        VerificationTest[
            ST[ a[i_], TI[ {i_} ] ] ST[ b[i_], TI[ {i_} ] ],
            Hold[ ST[ a[i_], TI[ {i_} ] ] ST[ b[i_], TI[ {i_} ] ] ],
            TestID -> "tensor cannot be multipled between each other"
        ]
    }
]
