(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-m-s.m"]


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,

        DI = SymbolicTensor`DumbIndex
    },
    
    VerificationTest[
        SS[ a[i_,j_] SS[ b[i_,j_,k_], SI[{k_}] ], SI[{i_},{j_}] ],
        SS[ a[DI[1],DI[2]] b[DI[1],DI[2],DI[3]], SI[{DI[1]},{DI[2]},{DI[3]}] ]
    ]
]
