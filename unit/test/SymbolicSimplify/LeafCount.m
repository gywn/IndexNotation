(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["SymbolicSimplify/LeafCount.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        DI = SymbolicTensor`DumbIndex,
        
        LC = SymbolicTensor`SymbolicSimplify`LeafCount
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
            LC @ ST[ SS[ A[DI[1],DI[2]], SI[{DI[1]}] ], TI[{DI[2]}] ],
            11,
            TestID -> "simple"
        ]
    }
]


End[];
