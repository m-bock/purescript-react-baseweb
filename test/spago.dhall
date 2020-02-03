{ name =
    "react-baseweb-test"
, license =
    "MIT"
, dependencies =
      (../src/spago.dhall).dependencies
    # [ "test-unit", "react-dom", "psci-support", "debug" ]
, packages =
    ../packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
