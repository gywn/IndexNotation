(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        DI = SymbolicTensor`DumbIndex
    },
    
    (* Rules outside of SymbolicTensor` *)
    
    MakeBoxes[k : KroneckerDelta[i__], StandardForm] := With[
        { boxes = SubscriptBox[ "\[Delta]", ToBoxes @ {i} ] },
        
        InterpretationBox[boxes, k]
    ];

    MakeBoxes[is : {__DI}, StandardForm] := With[
        { boxes = RowBox[ToBoxes /@ is] },
        
        InterpretationBox[boxes, is]
    ];

    MakeBoxes[v : Inverse[s_Symbol], StandardForm] := With[
        { boxes = SuperscriptBox[ ToBoxes[s], "-1" ] },
        
        InterpretationBox[boxes, v]
    ];
]


End[];
