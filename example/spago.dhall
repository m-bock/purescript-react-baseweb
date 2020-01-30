{ name =
    "baseui-example"
, license =
    "MIT"
, dependencies =
    [ "console"
    , "effect"
    , "partial"
    , "psci-support"
    , "react"
    , "quickcheck"
    , "test-unit"
    , "react-dom"
    , "web-html"
    , "debug"
    ]
, packages =
    ../packages.dhall
, sources =
    [ "src/**/*.purs", "example/**/*.purs" ]
}
