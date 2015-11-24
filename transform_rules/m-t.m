(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    IT /: p : Times[s_IT, y__] := Block[
        {x, vrs},

        If[
            \[Not] MemberQ[ {y}, _IT ],

            IT[x, vrs] = ScU[s];
            ScT[indexfunc] @ IT[ Times[x, y], vrs ],

            Hold[p]
        ]
    ];
]


End[];
