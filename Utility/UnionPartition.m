(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        iES = IndexNotation`Utility`UnionPartition`IrreducibleEmptySum,
        rES = IndexNotation`Utility`UnionPartition`ReducibleEmptySum,
        UP = IndexNotation`Utility`UnionPartition
    },
    
(**     UnionPartition
  *
  *   - UnionPartition[sets, vrs] gives a replacement list 'rpl' which satisfies
  *       + if 'index' is used in 'sets', 'index /. rpl' gives ID of the partition 
  *         cluster that 'index' is in;
  *       + if 'index' is unused and irreducible (doesn't have a order n), 'index /. rpl' gives 'iES'.
  *       + if 'index' is unused and reducible (have a order n), 'index /. rpl' gives 'rES'.
  *
  *   - 'Complement[ Values[rpl], Keys[rpl] ]' gives a list of partition clusters' IDs
  *     mixed with 'rES' and 'iES' if there is any.
  *)
    UP[ sets : {__List}, vrs_ ] := Block[
        {is, ris, rpl = <||>, used},
        
        is = Cases[ vrs, {i_, ___} :> i ];
        ris = Cases[ vrs, {i_, n_, ___} :> i ];
    
        (set \[Function] With[
            { setid = $ModuleNumber ++ },
            
            (vertex \[Function]
                If[
                    KeyExistsQ[rpl, vertex],
                    Block[
                        {sid = vertex //. rpl},

                        If[ sid =!= setid, rpl[sid] = setid ]
                    ],
                    rpl[vertex] = setid
                ]) /@ set

        ]) /@ sets;
        
        used = Complement[ Keys[rpl], Values[rpl] ];
        (vertex \[Function] rpl[vertex] = rES) /@ Complement[ris, used];
        (vertex \[Function] rpl[vertex] = iES) /@ Complement[is, ris, used];
        
        # //. rpl & /@ rpl   (* Accelerate clustering by shortening reference path *)
    ];
]


End[];
