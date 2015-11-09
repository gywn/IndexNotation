(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
        
        QSr = SymbolicTensor`QuotientStructure`Sort,
        QSp = SymbolicTensor`QuotientStructure`Split,
        
        msql = SymbolicTensor`Utility`OccurrenceSequence`MainSequential,
        sql = SymbolicTensor`Utility`OccurrenceSequence`Sequential,
        sml = SymbolicTensor`Utility`OccurrenceSequence`Simultaneous,
        CoS = SymbolicTensor`Utility`OccurrenceSequence`ComplexSequence,
        
        fill = SymbolicTensor`Utility`OccurrenceSequence`FillLocation,
        OcS = SymbolicTensor`Utility`OccurrenceSequence        
    },
    
(**     OccurrenceSequence`*
  *
  *   - Given index list 'is' and expression 'x', ComplexSequence produce a complex
  *     structure indicating occurrence sequence of elements of 'is' inside 'x', e.g.
  *
  *         seq = Sequential[ c, Simultaneous[ Sequential[a,b],Sequential[c,d] ], a, ...]
  *                           1  2             -          1 2  -          1 2     3
   *
  *     Then Trace produce an association 'loc' of indexes' locations in 'seq', e.g.
  *
  *         loc[a] := {{2,1},{3}}
  *         loc[b] := {{2,2}}
  *         loc[c] := {{1},{2,1}}
  *         loc[d] := {{2,2}}
  *
  *     At last, OccurrenceSequence mixes 'loc' and indexes together, insert it into
  *     'seq'. The sorting will be done automatically by Orderless attribute of 
  *     'Simultaneous'.
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
        sql @@ (eqset \[Function] sml @@ (y \[Function] CoS[y, is]) /@ eqset) /@ QSp[is][ {x1} ],
        sql @@ (y \[Function] CoS[y, is]) /@ {h, x1}
    ];

    CoS[i_, is_List] := sql[];
    
    SetAttributes[fill, HoldFirst];

    fill[ loc_, cur_, seq : (sql|msql)[___] ] :=
        (MapIndexed[ fill[loc, Append[cur,#2[[1]]], #1 ]&, seq ];);
        
    fill[loc_, cur_, seq_sml] := (fill[loc, cur, # ]& /@ seq;);
    
    fill[loc_, cur_, i_] := If[
        KeyExistsQ[loc, i],
        AppendTo[ loc[i], cur ],
        loc[i] = {cur}
    ];
    
    OcS[x_, is_List] := Block[
        {
            loc = <||>,
            seq = msql @ CoS[x, is]
        },
        
        fill[loc, {}, seq];   (* fill loc *)
        loc = QSr[{}][#]& /@ loc;

        (* Print[loc]; *)
        
        seq = seq
            /. i : (Alternatives @@ Verbatim /@ is) :> {loc[i], i}
            /. HoldPattern @ sml[x1__] :> sql @@ QSr[is][ {x1} ];
            (* sml and sql all have rewriting rules. They should be used with caution *)
    
        DeleteDuplicates[ List @@ (#[[2]]& /@ seq) ]
    ]
]


End[];
