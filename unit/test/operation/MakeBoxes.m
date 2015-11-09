(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["operation/MakeBoxes.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,

        DI = SymbolicTensor`DumbIndex
    },
    
    Global`RESULTS = 
    ST[ SS[ Subscript[A, {i_, j_, k_}], {k_} ], {i_,2}, {j_} ]
]


End[];
