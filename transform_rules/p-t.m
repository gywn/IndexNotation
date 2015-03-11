(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScY = SymbolicTensor`Scope`Yield,
		ScT = SymbolicTensor`Scope`Transform,
		
		indexfunc = SymbolicTensor`DumbIndex
	},
	
	ST /: Plus[ s1 : ST[x1_, vrs1_], s2 : ST[x2_, vrs2_], y___ ] 
		/; vrs1[[All,2;;-1]] === vrs2[[All,2;;-1]] (* same index structure *)
		:= Block[
			{ uniques, rpl1, rpl2 },
			
			uniques = Cases[ vrs1, {i_, ___} :> Unique[] ];
			rpl1 = MapThread[ Verbatim[#1] -> #2 &, {List @@ vrs1[[All,1]], uniques} ];
			rpl2 = MapThread[ Verbatim[#1] -> #2 &, {List @@ vrs2[[All,1]], uniques} ];
			
			Replace[
				PlusR[ ScR[#, rpl1]& /@ s1, ScR[#, rpl2]& /@ s2 ],
				PlusR[ ST[x3_, vrs3_], ST[x4_, vrs4_] ] :>
					ScT[indexfunc] @ ST[ x3 + x4, vrs3 ] + Plus[y]
			]
		];
]


End[];
