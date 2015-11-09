(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
        
        OcS = SymbolicTensor`Utility`OccurrenceSequence,
        DIL = SymbolicTensor`Utility`DumbIndexList
    },
    
(**     DumbIndexList
 *
 *    - return dumb index List for a closed-scope expression (e.g. SymbolicTensor)
 *    - if 'vrs' has Orderless head, order in the result is determinated by their
 *      appearance order in x, and then order in vrs.
 *)
    
    (* OPTIMIZATION: opt___ can be ___ ? *)
    
    DIL[ s : ScH[ x_, vrs : vh_[___], opt___], eis_List ] := If[
        MemberQ[ Attributes[vh], Orderless ],
        
        OcS[ {x, vrs, opt}, Cases[ vrs, {i_, ___} :> i ], eis ],
        Cases[ Reverse @ vrs, {i_, ___} :> i ]
    ];
]


End[];
