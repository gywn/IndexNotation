(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		OFML = SymbolicTensor`Utility`OrderedFreeMemberList,
		UP = SymbolicTensor`Utility`UnionPartition,
		ES = SymbolicTensor`Utility`UnionPartition`EmptySum,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScY = SymbolicTensor`Scope`Yield,
		ScT = SymbolicTensor`Scope`Transform,
		
		indexfunc = SymbolicTensor`DumbIndex,
		
		phony = SymbolicTensor`temp`PhonySymbolicSum
	},
	
	SS[ Times[ x_, y__ ], vrs_ ] := Block[
		{ freei, rpl, pids },
		
		freei = {#, OFML[ #, Verbatim /@ vrs[[All, 1]] ]}& /@ {x,y};
		rpl = UP[ freei[[All, 2]], Cases[ vrs, {i_, ___} :> i ] ];
		pids = Complement[ rpl[[All, 2]], rpl[[All, 1]] ];
		
		Block[
			{ partition, pid },
			
			partition[_] := phony[ 1, SI[] ];
			
			(* fill 'x' terms into partition, # === {'x',{indexes used in 'x'}} *)
			
			(
				pid = If[ #[[2]] === {}, ES, #[[2,1]] ] //. rpl;
				partition[ pid ] = phony[ partition[ pid ][[1]] * #[[1]], partition[ pid ][[2]] ]		
			)& /@ freei;
			
			(* fill 'vrs' terms into partition *)
			
			(
				pid = If[ (#[[1]] //. rpl) === #[[1]], ES, #[[1]] ] //. rpl;
				partition[ pid ] = phony[ partition[ pid ][[1]], Append[ partition[ pid ][[2]], # ] ]
			)& /@ vrs;
			
			ScT[indexfunc] @ Times @@ (SS @@ partition[#]& /@ pids)
			
		] /; Length[ pids ] =!= 1
	];
]


End[];
