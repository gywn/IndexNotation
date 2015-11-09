(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    (**
     *  Simple sum like (2+\[Pi]) won't be attributed
     *)
    
    SS[ Times[ Plus[x_, y__], z__ ], vrs_ ]
        (*/; OcS[ x, Verbatim /@ vrs[[All, 1]] ] =!= {}*)
        := SS[ Times[x,z] + Times[ Plus[y], z ], vrs ];
]


End[];
