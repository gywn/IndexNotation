(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex,
        
        VR = IndexNotation`Part`ValidRange
    },
    
    VR[ {i_, n_ ? IntegerQ, ___}, m_ ? IntegerQ ] := m <= n;
    
    VR[vr_, m_] := True;
    
    IT /: p :( s : IT[x_, vrs_, ___] )[[ms__]]
        := Block[
            {x1, vrs1, opt1, rpl},
            
            If[
                Length[vrs] === Length[{ms}] 
                    && And @@ MapThread[ VR, { List @@ vrs, Reverse @ {ms} } ],

                IT[x1, vrs1, opt1] = ScU[s];
                rpl = AssociationThread[ Cases[ vrs1, {i_, ___} :> i ], Reverse @ {ms} ];
                ScT[indexfunc][x1 /. rpl],

                Hold[p]
            ]
        ];
]



End[];
