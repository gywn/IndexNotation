(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
                
        SrI = IndexNotation`Utility`SortedIndex,
        UP = IndexNotation`Utility`UnionPartition,
        iES = IndexNotation`Utility`UnionPartition`IrreducibleEmptySum,
        rES = IndexNotation`Utility`UnionPartition`ReducibleEmptySum,
        
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex,
        
        mlp = IndexNotation`Private`MultiplicationFragment,
        idx = IndexNotation`Private`IndicesFragment
    },
    
    IS::ispp = "If you use IndexSum as pattern, consider wrap it with HoldPattern: `1`";
    
    s : IS[x_, vrs_] := Block[
        {is, mlps, clrpl, clids, valid, clmlp, clvar, free = 1},
        
        If[
            Internal`PatternPresentQ @ Hold[s],
            Message[ IS::ispp, HoldForm[s] ]
        ];
        
        is = Cases[ vrs, {i_, ___} :> i ];
        mlps = AssociationMap[ SrI[#, is]&, If[ MatchQ[x, _Times], List @@ x, {x} ] ];
        clrpl = UP[ Values[mlps], vrs ];
        clids = DeleteDuplicates @ Values[clrpl];
 
        valid = Length[clids] > 1 || clids === {rES} || ( clids =!= {iES} && MemberQ[ mlps, {} ] ); 
        If[
            valid,

            clmlp = GroupBy[
                mlps,
                If[ # === {}, rES, #[[1]] /. clrpl ] &
            ];
            clmlp = (ms \[Function] Times @@ Keys @ ms) /@ clmlp;
            If[
                KeyExistsQ[clmlp, rES],
                free = clmlp[rES]; KeyDropFrom[clmlp, rES]
            ];
            If[
                MemberQ[clids, iES],
                clmlp[iES] = 1
            ];
            
            clvar = SI[] & /@ clmlp;
            free = free Times @@ ( (vr \[Function] Block[
                {clid = vr[[1]] /. clrpl},

                If[
                    clid === rES,
                    vr[[2]],
                    AppendTo[ clvar[clid], vr ]; 1
                ]
            ]) /@ vrs );
            
            free ScT[indexfunc][ Times @@ Values @ MapThread[ IS, {clmlp, clvar} ] ] 
        ]
            /; valid
    ];
]


End[];
