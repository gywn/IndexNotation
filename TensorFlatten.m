(* ::Package:: *)

Begin["SymbolicTensor`temp`"];

With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        
        TF = SymbolicTensor`TensorFlatten
    },
    
    TF[x_] := ScU[x] //. {
        ST[ x1_, TI[vrs__] ] :> Table[ x1, Evaluate[ Sequence @@ Reverse @ {vrs} ] ],
        SS[ x1_, SI[vrs__] ] :> Sum[ x1, Evaluate[ Sequence @@ {vrs} ] ]
    };
]



End[];
