(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    { 
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex,
        
        LC = SymbolicTensor`SymbolicSimplify`LeafCount,
        RES = SymbolicTensor`SymbolicSimplify`ReduceEmptySum,
        TS = SymbolicTensor`SymbolicSimplify`Simplify
    },
    
    TS[x_, assum___] := Simplify[ ScT[indexfunc][x], assum,
        ComplexityFunction -> LC,
        TransformationFunctions -> {Automatic, RES}
    ];
];


End[];
