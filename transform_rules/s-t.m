(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    SS[s_ST, vrs2_] := Block[
        {x, vrs1},
        
        ST[x, vrs1] = ScU[s];
        ScT[indexfunc] @ ST[ SS[x, vrs2], vrs1 ]
    ];
]


End[];
