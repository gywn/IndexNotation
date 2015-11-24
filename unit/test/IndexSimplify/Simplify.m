(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["IndexSimplify/Simplify.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        DI = IndexNotation`DummyIndex,
        
        TS = IndexNotation`IndexSimplify`Simplify
    },
        
    Global`RESULTS = 
        VerificationTest[
            TS @ IS[ A, SI[{i,2},{j,2},{k,2}] ],
            8 A,
            TestID -> "1"
        ]
    }
]


End[];
