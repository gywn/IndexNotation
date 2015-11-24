(* ::Package:: *)

With[
    {
        packageDir = "IndexNotation",
        packageContext = "IndexNotation",
        appsPath = FileNameJoin[{ $UserBaseDirectory, "Applications" }],
        
        (* dep.py and init_test.m should be under the same folder.
         * "python dep.py -h" for more informations *)
        depPath = FileNameJoin[{ DirectoryName[$InputFileName], "dep.py" }]
    },

    Quiet[
        (con \[Function] Remove @ Evaluate @ StringJoin[con, "*"]) /@ Contexts[packageContext <> "*"],
        {Remove::rmnsm, Remove::rmptc}
        (* Message: no symbol matched & protected symbol *)
    ];

    RecursiveGet[s__] := Block[
        {cmd, packages},
        
        cmd = StringJoin @ Riffle[ Join[
            {"!", "python", depPath, "--apps-dir", appsPath, "--package-context", packageContext},
            "'" <> # <> "'" & /@ {s}
        ], " " ];
        packages = Import[cmd, {"Text", "Lines"}];

        Get[#]& /@ packages;

        (* Output all imported files *)
        Grid[ {#}& /@ packages, Alignment -> {Left, Baseline} ]
    ];
]
