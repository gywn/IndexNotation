(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,

        ScT = IndexNotation`Scope`Transform,
        indexfunc = IndexNotation`DummyIndex
    },
    
(**     IndexSum
 *
 *      IndexSum[x, SumIndex[{i, 3}, {j, 3}, ...]]
 *      IndexSum[IndexSum[x, SumIndex[{i, 3}]], SumIndex[{j, 3}, ...]]
 *
 *    - It's not recommanded to write IndexSum[x, SumIndex[__List]] directly.
 *      Write IndexSum[x, __List] instead to enable scope checking.
 *    - Allow using IndexSum[x, {i,3}, {j,3}] to build index notation sum
 *    - Syntax highlight in Mathematica front-end is supported.
 *)
    SetAttributes[IS, {NHoldRest}];
    SetAttributes[SI, {Orderless}];

    IS[ x_, SI[] ] := x;
    IS[x_] := x;

    (* Enable direct unpacking assignment *)

    IS /: ( IS[x1_, vrs1_] = IS[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
    );

    IS /: ( IS[x1_, vrs1_] = x2_ ) := (
        x1 = x2;
        vrs1 = SI[];
    );

    IS /: ( IS[x1_, vrs1_, opt1_] = IS[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
        opt1 = opt2;
    );

    (* grammar sugar *)
    
    s : IS[x_, vrl__List] := If[
        DuplicateFreeQ[ {vrl}[[All, 1]] ],
        ScT[indexfunc] @ Fold[ IS[#1, SI[#2]]&, x, {vrl} ],
        Hold[s]
    ];
    
    Options[IS] = {Type -> "Normal"}; (* Options[] must be placed before SyntaxInformation[] *)
    SyntaxInformation[IS] = {
        "LocalVariables" -> { "Table", {0, Infinity} },
        "ArgumentsPattern" -> { __, OptionsPattern[] }
    };
]


End[];
