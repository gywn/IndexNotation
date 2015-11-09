(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
    	ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
    	
    	DIL = SymbolicTensor`Utility`DumbIndexList,
    
    	ScU = SymbolicTensor`Scope`UniqueIndex,
    	ScTa = SymbolicTensor`Scope`TransformAux,
    	ScT = SymbolicTensor`Scope`Transform
    },	
    
(**     Transform
 *
 *    - Transform[indexfunc][x] rename all dumb indexes in x with indexfunc. 
 *    - Transform's goal is to assure that all structual equivalent expressions
 *      will be identical after index transformation. This is achieved by
 *      treating the expression as quotient expression (c.f. QuotientStructure)
 *      and generating its dumb indexes' occurence sequence (c.f.
 *      OccurenceSequence).
 *
 *      indexfunc
 *    
 *    - indexfunc[n] should return the n-th dumb index notation, beginning from 1.
 *    - indexfunct will be called in a random manner.
 *)    	
    ScT[indexfunc_][x_] := ScTa[indexfunc][ ScU[x], {} ];
    
    ScTa[indexfunc_][x_, eis_List] := 
    	x /. (h : ScH)[x1_, vrs_, opt___] :> Block[
            {uniqx, uniq, rpl},
    		
            uniqx = ScTa[indexfunc][ x1, Join[ eis, Cases[ vrs, {i_, ___} :> i ] ] ];
    		uniq = h[uniqx, vrs, opt];
    		rpl = Block[
    			{n = 0, new},
    			
    			(
    				While[ MemberQ[ uniq, Verbatim[ new = indexfunc[++n] ], Infinity ] ];
    				Verbatim[#] -> new
    			)& /@ DIL[uniq, eis]
    		];
    		uniq /. rpl
    	]
];    


End[];
