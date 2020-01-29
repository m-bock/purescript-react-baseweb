{ name =
    "baseui"
, license = "MIT"
, repository = "github.com/thought2/purescript-baseui"
, dependencies =
    [ "console"
    , "effect"
    , "partial"
    , "psci-support"
    , "react"
    , "react-dom"
    , "test-unit"
    , "typelevel-prelude"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
