(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,

        ScT = SymbolicTensor`Scope`Transform,
        indexfunc = SymbolicTensor`DumbIndex
    },
    
(**     SymbolicTensor
 *
 *      SymbolicTensor[x, TensorIndex[..., {j, 3}, {i, 3}]]
 *      SymbolicTensor[SymbolicTensor[x, TensorIndex[..., {j, 3}]], TensorIndex[{i, 3}]]
 *
 *    - It's not recommanded to write SymbolicTensor[x, TensorIndex[__List]] directly.
 *      Write SymbolicTensor[x, __List] instead to enable scope checking.
 *    - Allow using ST[x, {i,3}, {j,3}] to build symbolic tensor
 *    - Reverse the order of vrs to makes {j,3} inner-most item / first item to contract, 
 *      compatible with mathematica's "Table" function.
 *    - Derivation on x adds item on the side of {j,3}, compatible with tensorial calculus.
 *    - Syntax highlight in Mathematica front-end is supported.
 *)
    SetAttributes[ST, {NHoldRest}];
    SetAttributes[TI, {}];

    ST[ x_, TI[] ] := x;
    ST[x_] := x;
    
    (* Enable direct unpacking assignment *)

    ST /: ( ST[x1_, vrs1_] = ST[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
    );

    ST /: ( ST[x1_, vrs1_, opt1_] = ST[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
        opt1 = opt2;
    );

    (* grammar sugar *)
    
    t : ST[x_, vrl__List] := If[
        DuplicateFreeQ[ {vrl}[[All, 1]] ],
        ScT[indexfunc] @ Fold[ ST[#1, TI[#2]]&, x, Reverse @ {vrl} ],
        Hold[t]
    ];
    
    Options[ST] = {Type -> "Normal"}; (* Options[] must be placed before SyntaxInformation[] *)
    SyntaxInformation[ST] = {
        "LocalVariables" -> { "Table", {0, Infinity} },
        "ArgumentsPattern" -> { __, OptionsPattern[] }
    };
]


End[];
