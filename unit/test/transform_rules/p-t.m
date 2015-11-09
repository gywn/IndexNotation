(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/p-t.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        DI = SymbolicTensor`DumbIndex        
    },
    
    {
        VerificationTest[
            ST[ a[i_,j_], TI[{j_},{i_}] ] + ST[ b[k_,l_], TI[{l_},{k_}] ] + A,
            ST[ a[DI[1],DI[2]] + b[DI[1],DI[2]], TI[{DI[2]}, {DI[1]}] ] + A,
            TestID -> "simple 1"
        ],
        
        VerificationTest[
            ST[ a[i_,j_], TI[{i_}] ] + ST[ b[i_, j_], TI[{j_}] ] + A,
            ST[ a[DI[1],j_] + b[i_,DI[1]], TI[{DI[1]}] ] + A,
            TestID -> "simple 2"
        ],
        
        VerificationTest[
            ST[ a[i_,j_], TI[{i_, 2}] ] + ST[ b[i_, j_], TI[{j_}] ] + A,
            Hold[ A + ST[ a[i_,j_], TI[{i_, 2}] ] + ST[ b[i_, j_], TI[{j_}] ] ],
            TestID -> "incoherent tensor structure"
        ]
    }
]
