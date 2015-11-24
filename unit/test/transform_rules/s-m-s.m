(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-m-s.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,

        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = 
    VerificationTest[
        IS[ a[i_,j_] IS[ b[i_,j_,k_], SI[{k_}] ], SI[{i_},{j_}] ],
        IS[ a[DI[1],DI[2]] b[DI[1],DI[2],DI[3]], SI[{DI[1]},{DI[2]},{DI[3]}] ]
    ]
]


End[];
