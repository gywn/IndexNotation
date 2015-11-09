(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    ST /: Times[ s_ST, y__ ]
        /; \[Not] MemberQ[ {y}, _ST ]
        := Block[
            {x, vrs},

            ST[x, vrs] = ScU[s];
            ScT[indexfunc] @ ST[ Times[x,y], vrs ]
        ];
]


End[];
