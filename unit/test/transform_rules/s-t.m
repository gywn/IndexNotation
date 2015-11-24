(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-t.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        DI = IndexNotation`DummyIndex        
    },
    
    Global`RESULTS = {
        VerificationTest[
            IS[ IT[ a[j_,i_], TI[{j_}] ], SI[{i_}] ],
            IT[ IS[ a[DI[2],DI[1]], SI[{DI[1]}] ], TI[{DI[2]}] ],
            TestID -> "simple 1"
        ],
        
        VerificationTest[
            IS[ IT[ a[DI[4],DI[3],DI[2],DI[1]], TI[{DI[4]},{DI[3]}] ], SI[{DI[1]},{DI[2]}] ],
            IT[ IS[ a[DI[4],DI[3],DI[1],DI[2]], SI[{DI[1]},{DI[2]}] ], TI[{DI[4]},{DI[3]}] ],
            TestID -> "simple 2"
        ],
        
        VerificationTest[
            IS[ IT[ a[DI[1]], TI[{DI[1]}] ], SI[{DI[1]}] ],
            IT[ IS[ a[DI[2]], SI[{DI[1]}] ], TI[{DI[2]}] ],
            TestID -> "shadowing"
        ]
    }
]


End[];
