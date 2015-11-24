(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        KD = KroneckerDelta,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex
    },
    
    s : IS[
        x : Times[ KD[i_, j_, ___] | KD[i_, j_, ___]^_ ? IntegerQ, __ ]
            | KD[i_, j_, ___] | KD[i_, j_, ___]^_ ? IntegerQ,
        SI[ {i_, n___}, vrs___ ]
    ]
        /; i =!= j
        := Block[
            {vrj, x1},

            vrj = Cases[ {vrs}, {Verbatim @ j, ___} ];
            Which[
                vrj === {},

                x1 = ScU @ IS[ x, SI[vrs] ];
                ScT[indexfunc][ x1 /. <|i -> j|> ],

                MatchQ[ vrj, Verbatim @ {{j, n}} ],

                x1 = ScU @ IS[ x, SI @@ DeleteCases[ {vrs}, Verbatim @ {j, n} ] ];
                ScT[indexfunc][ IS[ x1 /. <|i -> j|>, SI[{j, n}] ] ],

                True,
                
                Hold[s]
            ]
        ];
]


End[];
