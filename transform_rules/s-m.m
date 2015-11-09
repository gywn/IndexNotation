(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
                
        OcS = SymbolicTensor`Utility`OccurrenceSequence,
        UP = SymbolicTensor`Utility`UnionPartition,
        iES = SymbolicTensor`Utility`UnionPartition`IrreducibleEmptySum,
        rES = SymbolicTensor`Utility`UnionPartition`ReducibleEmptySum,
        
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex,
        
        mlp = SymbolicTensor`temp`MultiplicationFragment,
        idx = SymbolicTensor`temp`IndexesFragment
    },
    
    s : SS[ p_Times | c_ ? AtomQ, vrs_ ] := Block[
        {x, is, mlps, clrpl, clids, valid, clmlp, clvar, free = 1},
        
        x = p c;
        is = Cases[ vrs, {i_, ___} :> i ];
        mlps = AssociationMap[ OcS[#, is]&, If[ AtomQ[x], {x}, List @@ x ] ];
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
            
            free ScT[indexfunc][ Times @@ Values @ MapThread[ SS, {clmlp, clvar} ] ] 
        ]
            /; valid
    ];
]


End[];
