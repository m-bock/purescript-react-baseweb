{ name =
    "react-baseweb-example"
, license =
    "MIT"
, dependencies =
    (../src/spago.dhall).dependencies # [ "react-dom", "web-html" ]
, packages =
    ../packages.dhall
, sources =
    [ "src/**/*.purs", "example/**/*.purs" ]
}
