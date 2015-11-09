(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["SymbolicSimplify/Simplify.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        DI = SymbolicTensor`DumbIndex,
        
        TS = SymbolicTensor`SymbolicSimplify`Simplify
    },
        
    Global`RESULTS = 
        VerificationTest[
            TS @ SS[ A, SI[{i,2},{j,2},{k,2}] ],
            8 A,
            TestID -> "1"
        ]
    }
]


End[];
