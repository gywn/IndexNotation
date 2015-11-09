(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
    	ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
    	
    	PPQ = SymbolicTensor`Utility`PatternPresentQ,
    	
    	ScR = SymbolicTensor`Scope`Replace,
    	ScY = SymbolicTensor`Scope`Yield
    },	
    
(**     Replace
 *
 *    - replace several dumb indexes one-by-one in part of x that is not
 *      shadowed by scopes which re-use these ghost indexes, i.e. replace only in real
 *      scope of these dumb indexes.
 *    - it handles {a\[Rule]b, b\[Rule]c} kind of replacement list with no problem.
 *    - algorithm logic demands that i to be verbatim, but it's the caller's responsibility
 *      to guarantee that. ( better not to call it directly )
 *)    	
    ScR[x_, rplist_List] := (
    	If[
    		PPQ @ rplist[[All, 1]],
    		Message[ScR::pat, HoldForm[rplist]]
    	];
    	x /. Prepend[
    		rplist,
    		s : ScH[x1_, vrs_, ___] :> Block[
    			{ rpl },
    			
    			rpl = Select[rplist, \[Not] MemberQ[vrs, {#[[1]], ___}]&];
    			ScR[#, rpl] & /@ ScY[ s, rpl[[All, 2]] ]
    		]
    	]
    );
    	
    ScR[x_, r : (_Rule|_RuleDelayed)] := ScR[x, {r}];
    	
    ScR[x_, {}] := x;
    	
    ScR::pat = "pattern-like rule left side `1` is used";
];


End[];
