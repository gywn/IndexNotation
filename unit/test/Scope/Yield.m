(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet[
    "Scope/Yield.m",
    "Scope/Transform.m"
]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ScY = SymbolicTensor`Scope`Yield,
        ScT = SymbolicTensor`Scope`Transform
    },
    
Block[
    {indexfunc},
    
    indexfunc[i_] := Idx[i];
    {
        VerificationTest[
            ScT[indexfunc] @ ScY[ SS[ B[i,j], SI[{i},{j}] ], Sin[i] ],
            SS[ B[Idx[1],Idx[2]], SI[{Idx[1]}, {Idx[2]}] ]
        ]
    }
]    
]
