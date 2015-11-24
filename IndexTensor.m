(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,

        ScT = IndexNotation`Scope`Transform,
        indexfunc = IndexNotation`DummyIndex
    },
    
(**     IndexTensor
 *
 *      IndexTensor[x, TensorIndex[..., {j, 3}, {i, 3}]]
 *      IndexTensor[IndexTensor[x, TensorIndex[..., {j, 3}]], TensorIndex[{i, 3}]]
 *
 *    - It's not recommanded to write IndexTensor[x, TensorIndex[__List]] directly.
 *      Write IndexTensor[x, __List] instead to enable scope checking.
 *    - Allow using IT[x, {i,3}, {j,3}] to build index notation tensor
 *    - Reverse the order of vrs to makes {j,3} inner-most item / first item to contract, 
 *      compatible with mathematica's "Table" function.
 *    - Derivation on x adds item on the side of {j,3}, compatible with tensorial calculus.
 *    - Syntax highlight in Mathematica front-end is supported.
 *)
    SetAttributes[IT, {NHoldRest}];
    SetAttributes[TI, {}];

    IT[ x_, TI[] ] := x;
    IT[x_] := x;
    
    (* Enable direct unpacking assignment *)

    IT /: ( IT[x1_, vrs1_] = IT[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
    );

    IT /: ( IT[x1_, vrs1_] = x2_ ) := (
        x1 = x2;
        vrs1 = TI[];
    );

    IT /: ( IT[x1_, vrs1_, opt1_] = IT[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
        opt1 = opt2;
    );

    (* grammar sugar *)
    
    t : IT[x_, vrl__List] := If[
        DuplicateFreeQ[ {vrl}[[All, 1]] ],
        ScT[indexfunc] @ Fold[ IT[#1, TI[#2]]&, x, Reverse @ {vrl} ],
        Hold[t]
    ];
    
    Options[IT] = {Type -> "Normal"}; (* Options[] must be placed before SyntaxInformation[] *)
    SyntaxInformation[IT] = {
        "LocalVariables" -> { "Table", {0, Infinity} },
        "ArgumentsPattern" -> { __, OptionsPattern[] }
    };
]


End[];
