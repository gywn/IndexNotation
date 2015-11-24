(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/m-t.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        DI = IndexNotation`DummyIndex        
    },
    
    Global`RESULTS = {
        VerificationTest[
            IT[ a[i_, DI[2]], TI[{DI[2]},{i_}] ] DI[2] Sin[DI[1]],
            IT[ a[DI[3],DI[4]] DI[2] Sin[DI[1]], TI[{DI[4]},{DI[3]}] ],
            TestID -> "forced internal dummy index change"
        ],
        
        VerificationTest[
            IT[ a[i_], TI[ {i_} ] ] IT[ b[i_], TI[ {i_} ] ],
            Hold[ IT[ a[i_], TI[ {i_} ] ] IT[ b[i_], TI[ {i_} ] ] ],
            TestID -> "tensor cannot be multipled between each other"
        ]
    }
]


End[];
