(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        FMQ = SymbolicTensor`Utility`FreeMemberQ,
        
        ScT = SymbolicTensor`Scope`Transform,
        indexfunc = SymbolicTensor`DumbIndex,
        
        RES = SymbolicTensor`SymbolicSimplify`ReduceEmptySum
    },
    
    RES @ s : SS[ x_, SI[ {i_, n_, ___}, vs___ ] ]
        /; \[Not] FMQ[ x, Verbatim @ i ]
        := ScT[indexfunc][ n SS[x, SI[vs]] ];
]


End[];
