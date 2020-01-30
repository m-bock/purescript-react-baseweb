module BaseUI.Common where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable)
import Data.Nullable as Nullable
import React (ReactClass)
import React as React

type Override props styleProps
  = { component :: Maybe (ReactClass props)
    , styles :: Maybe (styleProps -> Styles)
    , props :: Maybe props
    }

type OverrideImpl props styleProps
  = { component :: Nullable (ReactClass props)
    , styles :: Nullable (styleProps -> Styles)
    , props :: Nullable props
    }

overrideToImpl :: forall props styleProps. Override props styleProps -> OverrideImpl props styleProps
overrideToImpl props =
  { component: Nullable.toNullable props.component
  , styles: Nullable.toNullable props.styles
  , props: Nullable.toNullable props.props
  }

type Theme
  = {}

type Styles
  = {}

type T a
  = {}

defaultOverride :: Override {} {}
defaultOverride =
  { component: Nothing
  , styles: Nothing
  , props: Nothing
  }
