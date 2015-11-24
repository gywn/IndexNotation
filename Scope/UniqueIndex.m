(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        ScH = IndexNotation`IndexTensor | IndexNotation`IndexSum,
        
        ScD = IndexNotation`Scope`UniqueDummyIndex,
        ScU = IndexNotation`Scope`UniqueIndex
    },    

(**     UniqueIndex
 *
 *    - UniqueIndex[x_] replaces all dummy indices in x with unique variables.
 *      No unique variable is re-used as shadowed dummy index. This is the
 *      preparing step for IndexNotation`Scope`Transform.
 *)        
    ScU[x_, erpl_] := 
        x /. Prepend[
            erpl,
            s : ScH[x1_, vrs_, ___] :> Block[
                {rpl = Join[
                    Cases[ vrs, {i_, ___} :> Verbatim[i] -> ScD @ $ModuleNumber ++ ],
                    erpl
                ]},
                
                ScU[#, rpl]& /@ s
            ]
        ];
    
    ScU[x_] := ScU[x, {}];
];


End[];
