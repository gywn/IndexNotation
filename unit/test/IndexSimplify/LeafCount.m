(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["IndexSimplify/LeafCount.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        DI = IndexNotation`DummyIndex,
        
        LC = IndexNotation`IndexSimplify`LeafCount
    },
    
    Global`RESULTS = {
        Block[
            { expr = HEAD[A1, A2_, 3.3][ B1_[2,C2], "S" ] },
        
            VerificationTest[
                LC[expr],
                LeafCount[expr],
                TestID -> "compare with system's LeafCount"
            ]
        ],
    
        VerificationTest[
            LC @ IT[ IS[ A[DI[1],DI[2]], SI[{DI[1]}] ], TI[{DI[2]}] ],
            11,
            TestID -> "simple"
        ]
    }
]


End[];
