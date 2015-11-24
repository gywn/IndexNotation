(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        ScH = IndexNotation`IndexTensor | IndexNotation`IndexSum,
        
        SrI = IndexNotation`Utility`SortedIndex,
        ScL = IndexNotation`Scope`DummyIndexList
    },
    
(**     DummyIndexList
 *
 *    - return dummy index List for a closed-scope expression (e.g. IndexTensor)
 *    - if 'vrs' has Orderless head, order in the result is determinated by their
 *      appearance order in x, and then order in vrs.
 *)
    
    (* OPTIMIZATION: opt___ can be ___ ? *)
    
    ScL[ s : ScH[ x_, vrs : vh_[___], opt___], eis_List ] := If[
        MemberQ[ Attributes[vh], Orderless ],
        
        SrI[ {x, vrs, opt}, Cases[ vrs, {i_, ___} :> i ], eis ],
        Cases[ Reverse @ vrs, {i_, ___} :> i ]
    ];
]


End[];
