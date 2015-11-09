(* ::Package:: *)

Begin["SymbolicTensor`temp`"];

With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex,
        
        VR = SymbolicTensor`Part`ValidRange
    },
    
    VR[ {i_, n_ ? IntegerQ, ___}, m_ ? IntegerQ ] := m <= n;
    
    VR[vr_, m_] := True;
    
    ST /: p :( s : ST[x_, vrs_, ___] )[[ms__]]
        := Block[
            {x1, vrs1, opt1, rpl},
            
            If[
                Length[vrs] === Length[{ms}] 
                    && And @@ MapThread[ VR, { List @@ vrs, Reverse @ {ms} } ],

                ST[x1, vrs1, opt1] = ScU[s];
                rpl = AssociationThread[ Cases[ vrs1, {i_, ___} :> i ], Reverse @ {ms} ];
                ScT[indexfunc][x1 /. rpl],

                Hold[p]
            ]
        ];
]



End[];
