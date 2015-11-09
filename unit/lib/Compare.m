(* ::Package:: *)

SetAttributes[Compare, HoldAll];

Compare[ eval_, check_ ] := If[
    eval === check,
    (*Print["ok"]; *)True,
    Print[
    	"error     ", HoldForm[eval], 
    	"\n      --> ", eval,
    	"\n      =!= ", check
    ]; False
];

Compare[ args___ ] := Print[ "Compare gets incorrect number of arguments: ", Length[{args}] ];
