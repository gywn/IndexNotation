(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        ScH = IndexNotation`IndexTensor | IndexNotation`IndexSum,
        
        QSr = IndexNotation`Utility`QuotientStructure`Sort,
        QGt = IndexNotation`Utility`QuotientStructure`Gather,
        
        msql = IndexNotation`Utility`SortedIndex`MainSequential,
        sql = IndexNotation`Utility`SortedIndex`Sequential,
        sml = IndexNotation`Utility`SortedIndex`Simultaneous,
        CoS = IndexNotation`Utility`SortedIndex`ComplexSequence,
        
        fill = IndexNotation`Utility`SortedIndex`FillLocation,
        SrI = IndexNotation`Utility`SortedIndex        
    },
    
(**     SortedIndex`*
  *
  *   - Given index list 'is' and expression 'x', ComplexSequence produce a
  *     complex structure indicating occurrence sequence of elements of 'is'
  *     inside 'x', e.g.
  *
  *         seq = Sequential[ c, Simultaneous[ Sequential[a,b],Sequential[c,d] ], a, ...]
  *                           1  2             -          1 2  -          1 2     3
   *
  *     Then FillLocation produce an association 'loc' of indices' locations in
  *     'seq', then sort it with QuotientStructure`*, e.g.
  *
  *         loc[c] := {{1},{2,1}}
  *         loc[a] := {{2,1},{3}}
  *         loc[b] := {{2,2}}
  *         loc[d] := {{2,2}}
  *
  *     loc is then split into clusters, only the first cluster is taken as
  *     sorted, elements from the such cluster are 'instantiated' in 'seq', and
  *     deleted from 'is'. The new 'seq' and new 'is' are then used to call
  *     OccurenceSequence again, until seq is empty.
  *
  *     Mathematically speaking, this algorithm is correct when the first
  *     cluster has always only one element. The fully correct algorithm is yet
  *     to be constructed.
  *)    
    SetAttributes[sml, Orderless];
    
    sql[x1___, sql[x2___], x3___] := sql[x1, x2, x3];
    msql[x1___, sql[x2___], x3___] := msql[x1, x2, x3];
    
    sml[sql[], x___] := sml[x];
    sml[x_] := x;
    sml[] := Sequence[];

    CoS[i_, {___, i_, ___}] := i;

    CoS[s : ScH[_, vrs_, ___], is_List]
        := CoS[ List @@ s, Complement[ is, Cases[ vrs, {i_, ___} :> i ] ] ];

    CoS[ h_[x1___], is_List ] := If[
        MatchQ[h, _Symbol] && MemberQ[ Attributes[h], Orderless ],
        sql @@ (eqset \[Function] sml @@ (y \[Function] CoS[y, is]) /@ eqset) /@ QGt[is][ {x1} ],
        sql @@ (y \[Function] CoS[y, is]) /@ {h, x1}
    ];

    CoS[i_, is_List] := sql[];
    
    SetAttributes[fill, HoldFirst];

    fill[ loc_, cur_, seq : (sql|msql)[___] ] :=
        (MapIndexed[ fill[loc, Append[cur, #2[[1]]], #1 ]&, seq ];);
        
    fill[loc_, cur_, seq_sml] := (fill[loc, cur, # ]& /@ seq;);
    
    fill[loc_, cur_, i_] := If[
        KeyExistsQ[loc, i],
        AppendTo[ loc[i], cur ],
        loc[i] = {cur}
    ];
    
    SrI[x_, sorted_List, is_List, eis_List] := Block[
        {
            srt, cnt,
            loc = <||>,
            seq = msql @ CoS[ x, Join[is, eis] ]
        },

        If[
            seq =!= msql[],

            fill[loc, {}, seq];   (* fill loc *)
            loc = QSr[{}][#]& /@ loc;
            cnt = Counts[Values @ loc];
            loc = QSr[is] @ AssociationMap[
                Block[
                    { c = cnt @ #[[2]] },

                    #[[1]] -> { c, If[ c === 1, 0, #[[1]] ], #[[2]] }
                ]&,
                loc
            ]; 
            srt = First @ SplitBy[Keys @ loc, loc];
            
            SrI[
                seq /. (Verbatim[#] -> $ModuleNumber ++& /@ srt),
                Join[ sorted, Complement[srt, eis] ],
                Complement[is, srt],
                Complement[eis, srt]
            ],

            sorted
        ]
    ];
    
    SrI[x_, is_List, eis_List] := SrI[x, {}, is, eis];
    
    SrI[x_, is_List] := SrI[ x, {}, is, {} ];
]


End[];
