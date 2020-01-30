-- | - [Original source (v9.49.2)](https://github.com/uber/baseweb/blob/v9.49.2/src/index.js)
module BaseUI
  ( baseProvider
  , BaseProviderProps
  , BaseProviderPropsMandatory
  , BaseProviderPropsOptional
  , defaultBaseProviderProps
  , Theme
  , darkTheme
  , lightTheme
  , BaseProviderOverrides
  ) where

import Prelude
import React (ReactClass)
import React as React

-- API
--
baseProvider :: ReactClass BaseProviderProps
baseProvider =
  React.statelessComponent
    (\props -> React.createLeafElement baseProviderImpl $ baseProviderPropsToImpl props)

type BaseProviderProps
  = { | BaseProviderPropsMandatory BaseProviderPropsOptional }

type BaseProviderPropsMandatory r
  = ( children :: React.Children | r )

type BaseProviderPropsOptional
  = ( theme :: Theme )

defaultBaseProviderProps :: { | BaseProviderPropsOptional }
defaultBaseProviderProps = { theme: lightTheme }

-- INTERNAL
--
foreign import baseProviderImpl :: ReactClass BaseProviderPropsImpl

foreign import data Theme :: Type

foreign import lightTheme :: Theme

foreign import darkTheme :: Theme

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

baseProviderPropsToImpl :: BaseProviderProps -> BaseProviderPropsImpl
baseProviderPropsToImpl props = props --{ overrides = baseProviderOverridesToImpl props.overrides }

baseProviderOverridesToImpl :: BaseProviderOverrides -> BaseProviderOverridesImpl
baseProviderOverridesToImpl = identity

defaultBaseProviderOverrides :: BaseProviderOverrides
defaultBaseProviderOverrides = {}
