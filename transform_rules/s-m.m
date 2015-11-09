(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
                
        OcS = SymbolicTensor`Utility`OccurrenceSequence,
        UP = SymbolicTensor`Utility`UnionPartition,
        ES = SymbolicTensor`Utility`UnionPartition`EmptySum,
        
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex,
        
        mlp = SymbolicTensor`temp`MultiplicationFragment,
        idx = SymbolicTensor`temp`IndexesFragment
    },
    
    SS[ Times[ x_, y__ ], vrs_ ] := Block[
        { univ, mlps, clrpl, unused, clmlp, clvar },
        
        univ = Cases[ vrs, {i_, ___} :> i ];
        mlps = <| mlp -> #, idx -> OcS[ #, univ ] |> & /@ {x,y};
        clrpl = UP[ mlps[[All, Key @ idx]], univ ];
        unused = Keys @ Select[ clrpl, # === ES & ];
        If[
            unused =!= {},
            AppendTo[ mlps, <| mlp -> 1, idx -> unused |> ]
        ];
        
        clmlp = GroupBy[
            mlps,
            If[ #[idx] === {}, ES, #[idx][[1]] //. clrpl ] &
        ];
        
        (
            clmlp = (ms \[Function] Times @@ ms[[All,Key @ mlp]]) /@ clmlp;
            
            clvar = SI[] & /@ clmlp;
            (vr \[Function] AppendTo[ clvar[vr[[1]] //. clrpl], vr ]) /@ vrs;
        
            ScT[indexfunc][ Times @@ Values @ MapThread[ SS, {clmlp,clvar} ] ] 
        )
            /; Length[ clmlp ] =!= 1
        
    ];
]


End[];
