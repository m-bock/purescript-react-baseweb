module BaseUI
  ( lightTheme
  , darkTheme
  , baseProvider
  , BaseProviderProps
  , Theme
  , BaseProviderOverrides
  , BaseProviderProps'
  , defaultBaseProviderProps'
  , BaseProviderPropsRow'
  ) where

import Prelude
import React (ReactClass)
import React as React

foreign import baseProviderImpl :: ReactClass BaseProviderPropsImpl

foreign import data Theme :: Type

foreign import lightTheme :: Theme

foreign import darkTheme :: Theme

-- --, overrides :: BaseProviderOverrides  --, zIndex :: Int
type BaseProviderPropsRow'
  = ( theme :: Theme
    )

type BaseProviderProps'
  = { | BaseProviderPropsRow' }

type BaseProviderProps
  = { children :: React.Children | BaseProviderPropsRow' }

type BaseProviderPropsImpl
  = { children :: React.Children
    -- , overrides :: BaseProviderOverridesImpl
    , theme :: Theme
    --, zIndex :: Int
    }

type BaseProviderOverrides
  = {}

type BaseProviderOverridesImpl
  = {}

-- | https://baseweb.design/components/base-provider
baseProvider :: ReactClass BaseProviderProps
baseProvider =
  React.statelessComponent
    (\props -> React.createLeafElement baseProviderImpl $ baseProviderPropsToImpl props)

baseProviderPropsToImpl :: BaseProviderProps -> BaseProviderPropsImpl
baseProviderPropsToImpl props = props --{ overrides = baseProviderOverridesToImpl props.overrides }

baseProviderOverridesToImpl :: BaseProviderOverrides -> BaseProviderOverridesImpl
baseProviderOverridesToImpl = identity

defaultBaseProviderProps' :: BaseProviderProps'
defaultBaseProviderProps' = { theme: lightTheme } -- {--, overrides: defaultBaseProviderOverrides --, zIndex: 0}

defaultBaseProviderOverrides :: BaseProviderOverrides
defaultBaseProviderOverrides = {}
