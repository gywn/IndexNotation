(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        KD = KroneckerDelta,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex
    },
    
    s : SS[
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

                x1 = ScU @ SS[ x, SI[vrs] ];
                ScT[indexfunc][ x1 /. <|i -> j|> ],

                MatchQ[ vrj, Verbatim @ {{j, n}} ],

                x1 = ScU @ SS[ x, SI @@ DeleteCases[ {vrs}, Verbatim @ {j, n} ] ];
                ScT[indexfunc][ SS[ x1 /. <|i -> j|>, SI[{j, n}] ] ],

                True,
                
                Hold[s]
            ]
        ];
]


End[];
