(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    { 
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex,
        
        LC = IndexNotation`IndexSimplify`LeafCount,
        TS = IndexNotation`IndexSimplify`Simplify
    },
    
    TS[x_, assum___] := Simplify[ ScT[indexfunc][x], assum,
        ComplexityFunction -> LC,
        TransformationFunctions -> {Automatic}
    ];
];


End[];
