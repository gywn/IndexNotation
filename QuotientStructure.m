(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        QO = SymbolicTensor`QuotientStructure`Order,
        wp = SymbolicTensor`QuotientStructure`Order`Wrapper,
        QOQ = SymbolicTensor`QuotientStructure`OrderedQ,
        QSr = SymbolicTensor`QuotientStructure`Sort,
        QSQ = SymbolicTensor`QuotientStructure`SameQ,
        QGt = SymbolicTensor`QuotientStructure`Gather
    },
    
(**   # QuotientStructure`Order
  *
  *   - QuotientStructure`Order[is][x,y] gives similar result as Order[x,y], but treat expressions
  *     in 'is' as equivalences and always smaller than all other expressions:
  *     
  *         QuotientStructure`Order[is][x,y] /; x \[Element] is \[And] y \[Element] is     \[LongRightArrow]    0
  *         QuotientStructure`Order[is][x,y] /; x \[Element] is \[And] \[Not] y \[Element] is   \[LongRightArrow]   +1
  *         QuotientStructure`Order[is][x,y] /; \[Not] x \[Element] is \[And] y \[Element] is   \[LongRightArrow]   -1
  *         
  *   - 'is' won't be considered as wrapped by Verbatim.
  *
  *
  *   # QuotientStructure`OrderedQ
  *   # QuotientStructure`SameQ
  *   # QuotientStructure`Sort
  *   # QuotientStructure`Gather
  *
  *     They are 'quotient' counter parts of OrderedQ, SameQ, Sort and Gather.
  *)    
  
    QO[is_List][x_, y_] := Block[
        {
            xm = MemberQ[ is, Verbatim[x] ],
            ym = MemberQ[ is, Verbatim[y] ]
        },
        
        Switch[ {xm, ym},
            {True, False}, -1,
            {True, True},   0,
            {False, True}, +1
        ]
            /; xm || ym
    ];
    
    QO[is_List][wp[x_, xs___], wp[y_, ys___]] := Block[
        { o = QO[is][x, y] },
        
        If[ o === 0, QO[is][wp[xs], wp[ys]], o ]
    ];
    
    QO[is_List][wp[], wp[y__]] := 1;
    
    QO[is_List][wp[], wp[]] := 0;
    
    QO[is_List][wp[x__], wp[]] := -1;
    
    QO[is_List][p_[x___], q_[y___]] := Block[
        {
            o = QO[is][p, q],
            xsr = If[ MatchQ[p, _Symbol] && MemberQ[Attributes[p], Orderless], QSr[is][ {x} ], {x} ],
            ysr = If[ MatchQ[q, _Symbol] && MemberQ[Attributes[q], Orderless], QSr[is][ {y} ], {y} ]
        },
        
        If[ o === 0, QO[is][wp @@ xsr, wp @@ ysr], o ]
    ];
    
    QO[is_List][p_, q_[y___]] := 1;
    
    QO[is_List][p_[x___], q_] := -1;
    
    QO[_List][x_, y_] := Order[x, y];

    QOQ[is_List][x_, y_] := QO[is][x, y] >= 0;

    QSr[is_List][xs_List|xs_Association] := Sort[ xs, QOQ[is] ];
    
    QSQ[is_List][x_, y_] := QO[is][x, y] === 0;
    
    QGt[is_List][xs_List] := Split[ QSr[is][xs], QSQ[is] ];
]


End[];
