(* ::Package:: *)

<< SymbolicTensorDev`Utility`FreeMemberQ`
<< SymbolicTensorDev`Utility`OrderedFreeMemberList`
<< SymbolicTensorDev`Utility`DumbIndexList`
<< SymbolicTensorDev`Utility`PatternPresentQ`
<< SymbolicTensorDev`Utility`UnionPartition`

<< SymbolicTensorDev`Scope`Yield`
<< SymbolicTensorDev`Scope`Replace`
<< SymbolicTensorDev`Scope`Transform`

<< SymbolicTensorDev`SymbolicTensor`
<< SymbolicTensorDev`SymbolicSum`
<< SymbolicTensorDev`DumbIndex`

<< "SymbolicTensorDev/transform_rules/t-t.m"
<< "SymbolicTensorDev/transform_rules/m-t.m"
<< "SymbolicTensorDev/transform_rules/s-t.m"
<< "SymbolicTensorDev/transform_rules/p-t.m"
<< "SymbolicTensorDev/transform_rules/s-m-s.m"
<< "SymbolicTensorDev/transform_rules/s-m-p.m"
<< "SymbolicTensorDev/transform_rules/s-m.m"
<< "SymbolicTensorDev/transform_rules/s-s.m"
<< "SymbolicTensorDev/transform_rules/s-p.m"

<< SymbolicTensorDev`SymbolicSimplify`
<< SymbolicTensorDev`SymbolicSimplify`EmptySum`
<< SymbolicTensorDev`SymbolicSimplify`LeafCount`

(**   - inject SymbolicTensor` into $ContextPath
 *    - define some shortcuts
 *)
BeginPackage["SymbolicTensor`"];
	
	ST = SymbolicTensor`SymbolicTensor;
	SS = SymbolicTensor`SymbolicSum;
	
EndPackage[];






