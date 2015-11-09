(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    SS[ Plus[x_, y__], vrs_ ]
        (*/; OcS[ x, Verbatim /@ vrs[[All, 1]] ] =!= {}*)
        := SS[x, vrs] + SS[Plus[y], vrs];
]


End[];
