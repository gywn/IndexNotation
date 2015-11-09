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
    
    ST /: p : Times[s_ST, y__] := Block[
        {x, vrs},

        If[
            \[Not] MemberQ[ {y}, _ST ],

            ST[x, vrs] = ScU[s];
            ScT[indexfunc] @ ST[ Times[x, y], vrs ],

            Hold[p]
        ]
    ];
]


End[];
