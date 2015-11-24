(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,

        DI = IndexNotation`DummyIndex,
        
        IA = IndexNotation`$IndexAlphabet,
        IB = IndexNotation`$IndexBackground,
        IFC = IndexNotation`$IndexFontColor
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
    
    IT /: MakeBoxes[s : IT[ x_, TI[is__List] ], StandardForm] := With[
        { boxes = SubscriptBox[
            StyleBox[ RowBox[{ "[", ToBoxes[x], "]" }], SpanMaxSize -> Infinity ],
            RowBox[ ToBoxes /@ First /@ Reverse[{is}] ]
        ] },
        
        InterpretationBox[boxes, s]
    ];
    
    IS /: MakeBoxes[s : IS[ x_, SI[is__List] ], StandardForm] := With[
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
