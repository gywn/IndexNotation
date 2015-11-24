(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["IndexSimplify/ReduceEmptySum.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        DI = IndexNotation`DummyIndex,
        
        RES = IndexNotation`IndexSimplify`ReduceEmptySum
    },
        
    Global`RESULTS = 
    VerificationTest[
        RES @ IS[ A, SI[{i,2},{j,2},{k,2}] ],
        2 IS[ A, SI[{DI[1],2},{DI[2],2}] ],
        TestID -> "only one step"
    ]
]


End[];
