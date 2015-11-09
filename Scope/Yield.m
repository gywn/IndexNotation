(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
        
        FMQ = SymbolicTensor`Utility`FreeMemberQ,
        
        ScR = SymbolicTensor`Scope`Replace,
        ScY = SymbolicTensor`Scope`Yield
    },    

(**     Yield
 *
 *    - Yield[s, x] prepares 's' for intrusion of 'x', i.e. alternate 'vrs' in 's'
 *      so that free indexes in x won't be shielded by 'vrs'.
 *)        
    ScY[s : ScH[x1_, vrs_, ___], x_] := Block[
        { yieldl = Cases[ vrs, 
            {i_, ___} /; FMQ[ x, i ] :> Verbatim[i] -> Unique[] ] },
        
        ScR[ #, yieldl ] & /@ s
    ];
];


End[];
