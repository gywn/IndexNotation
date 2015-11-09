(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["SymbolicSimplify/ReduceEmptySum.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        DI = SymbolicTensor`DumbIndex,
        
        RES = SymbolicTensor`SymbolicSimplify`ReduceEmptySum
    },
        
    Global`RESULTS = 
    VerificationTest[
        RES @ SS[ A, SI[{i,2},{j,2},{k,2}] ],
        2 SS[ A, SI[{DI[1],2},{DI[2],2}] ],
        TestID -> "only one step"
    ]
]


End[];
