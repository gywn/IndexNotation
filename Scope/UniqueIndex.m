(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
    	ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
    	
    	ScU = SymbolicTensor`Scope`UniqueIndex
    },	

(**     UniqueIndex
 *
 *    - UniqueIndex[x_] replaces all dumb indexes in x with unique variables.
 *      No unique variable is re-used as shadowed dumb index. This is the
 *      preparing step for SymbolicTensor`Scope`Transform.
 *)    	
    ScU[x_, erpl_] := 
    	x /. Prepend[
    		erpl,
    		s : ScH[x1_, vrs_, ___] :> Block[
    			{rpl = Join[
    				Cases[ vrs, {i_, ___} :> Verbatim[i] -> Unique[] ],
    				erpl
    			]},
    			
    			ScU[#, rpl]& /@ s
    		]
    	];
    
    ScU[x_] := ScU[x, {}];
];


End[];
