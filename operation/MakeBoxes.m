(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,

        DI = SymbolicTensor`DumbIndex,
        
        IA = SymbolicTensor`$IndexAlphabet,
        IB = SymbolicTensor`$IndexBackground,
        IFC = SymbolicTensor`$IndexFontColor
    },
    
    IA = {
        "\[Alpha]", "\[Beta]", "\[Gamma]", "\[Delta]",
        "\[Epsilon]", "\[Zeta]", "\[Eta]", "\[Theta]",
        "\[Iota]", "\[Kappa]", "\[Lambda]", "\[Mu]", 
        "\[Nu]", "\[Xi]", "\[Omicron]", "\[Pi]",
        "\[Rho]", "\[Sigma]", "\[Tau]", "\[Upsilon]",
        "\[Phi]", "\[Chi]", "\[Psi]", "\[Omega]"
    };
    IB = Automatic;
    IFC = Gray;
    
    ST /: MakeBoxes[s : ST[ x_, TI[is__List] ], StandardForm] := With[
        { boxes = SubscriptBox[
            StyleBox[ RowBox[{ "[", ToBoxes[x], "]" }], SpanMaxSize -> Infinity ],
            RowBox[ ToBoxes /@ First /@ Reverse[{is}] ]
        ] },
        
        InterpretationBox[boxes, s]
    ];
    
    SS /: MakeBoxes[s : SS[ x_, SI[is__List] ], StandardForm] := With[
        { boxes = RowBox[{
            UnderscriptBox[ "\[Sum]", RowBox[ ToBoxes /@ First /@ {is} ] ],
            StyleBox[ RowBox[{ "(", ToBoxes[x], ")" }], SpanMaxSize -> Infinity ]
        }] },
        
        InterpretationBox[boxes, s]
    ];
    
    DI /: MakeBoxes[i : DI[n_ ? IntegerQ], StandardForm] /; n <= Length[IA] := With[
        { boxes = StyleBox[ IA[[n]], Background -> IB, FontColor -> IFC ] },
        
        InterpretationBox[boxes, i]
    ];
]


End[];
