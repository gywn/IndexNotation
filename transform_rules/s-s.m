(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    SS[ s_SS, vrs2_ ] :=  Block[
        {x, vrs1},
        
        SS[x, vrs1] = ScU[s];
        ScT[indexfunc] @ SS[ x, Join[vrs1, vrs2] ]
    ];
]


End[];
