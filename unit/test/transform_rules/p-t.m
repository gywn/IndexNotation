(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/p-t.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        DI = IndexNotation`DummyIndex        
    },
    
    Global`RESULTS = {
        VerificationTest[
            IT[ a[i_,j_], TI[{j_},{i_}] ] + IT[ b[k_,l_], TI[{l_},{k_}] ] + A,
            IT[ a[DI[1],DI[2]] + b[DI[1],DI[2]], TI[{DI[2]}, {DI[1]}] ] + A,
            TestID -> "simple 1"
        ],
        
        VerificationTest[
            IT[ a[i_,j_], TI[{i_}] ] + IT[ b[i_, j_], TI[{j_}] ] + A,
            IT[ a[DI[1],j_] + b[i_,DI[1]], TI[{DI[1]}] ] + A,
            TestID -> "simple 2"
        ],
        
        VerificationTest[
            IT[ a[i_,j_], TI[{i_, 2}] ] + IT[ b[i_, j_], TI[{j_}] ] + A,
            Hold[ A + IT[ a[i_,j_], TI[{i_, 2}] ] + IT[ b[i_, j_], TI[{j_}] ] ],
            TestID -> "incoherent tensor structure"
        ]
    }
]


End[];
