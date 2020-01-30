module BaseUI.Button
  ( button
  , Kind(..)
  , Shape(..)
  , Size(..)
  , Type(..)
  , ButtonProps
  , ButtonOverrides
  , defaultButtonProps'
  , ButtonPropsRow'
  ) where

import Prelude
import BaseUI.Common (Override, OverrideImpl, defaultOverride, overrideToImpl)
import Data.Generic.Rep (class Generic)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import React (ReactClass)
import React as React
import Test.QuickCheck (class Arbitrary)
import Test.QuickCheck.Arbitrary (genericArbitrary)
import Unsafe.Coerce (unsafeCoerce)

foreign import buttonImpl :: ReactClass ButtonPropsImpl

data Kind
  = KindPrimary
  | KindSecondary
  | KindTertiary
  | KindMinimal

data Shape
  = ShapeDefault
  | ShapePill
  | ShapeRound
  | ShapeSquare

data Size
  = SizeMini
  | SizeDefault
  | SizeCompact
  | SizeLarge

data Type
  = TypeSubmit
  | TypeReset
  | TypeButton

type ButtonOverrides
  = { baseButton :: Override {} {} }

type ButtonOverridesImpl
  = { baseButton :: OverrideImpl {} {} }

type ButtonPropsRow'
  = ( disabled :: Boolean
    --, endEnhancer :: Unit -> ReactElement
    --, isLoading :: Boolean
    --, isSelected :: Boolean
    --, kind :: Kind
    , onClick :: Effect Unit
    --   , overrides :: ButtonOverrides
    , shape :: Shape
    --, size :: Size
    --, startEnhancer :: Unit -> ReactElement
    --, type :: Type
    )

type ButtonProps'
  = { | ButtonPropsRow' }

type ButtonProps
  = { children :: React.Children
    | ButtonPropsRow'
    }

type ButtonPropsImpl
  = { children :: React.Children
    , disabled :: Boolean
    --, endEnhancer :: Fn1 Unit ReactElement
    --, isLoading :: Boolean
    --, isSelected :: Boolean
    --, kind :: String
    , onClick :: EffectFn1 Unit Unit
    --  , overrides :: ButtonOverridesImpl
    , shape :: String
    --, size :: String
    --, startEnhancer :: Fn1 Unit ReactElement
    --, type :: String
    }

-- | https://baseweb.design/components/button/
button :: ReactClass ButtonProps
button =
  React.statelessComponent
    (\props -> React.createLeafElement buttonImpl $ buttonPropsToImpl props)

defaultButtonProps' :: ButtonProps'
defaultButtonProps' =
  { disabled: false
  --, endEnhancer: const $ DOM.text ""
  --, isLoading: false
  --, isSelected: false
  --, kind: KindPrimary
  , onClick: pure unit
  -- , overrides: defaultButtonOverrides
  , shape: ShapeDefault
  --, size: SizeDefault
  --, startEnhancer: const $ DOM.text ""
  --, type: TypeButton
  }

defaultButtonOverrides :: ButtonOverrides
defaultButtonOverrides = { baseButton: defaultOverride }

buttonPropsToImpl :: ButtonProps -> ButtonPropsImpl
buttonPropsToImpl props =
  props
    -- endEnhancer = mkFn1 props.endEnhancer  
    -- , kind = kindToString props.kind
    { onClick = mkEffectFn1 \_ -> props.onClick
    --   , overrides = buttonOverridesToImpl props.overrides
    , shape = shapeToString props.shape
    -- , size = sizeToString props.size
    -- , startEnhancer = mkFn1 props.startEnhancer
    -- , type = typeToString props.type
    }

buttonOverridesToImpl :: ButtonOverrides -> ButtonOverridesImpl
buttonOverridesToImpl rec = { baseButton: overrideToImpl rec.baseButton }

kindToString :: Kind -> String
kindToString = case _ of
  KindPrimary -> "primary"
  KindSecondary -> "secondary"
  KindTertiary -> "teriary"
  KindMinimal -> "minimal"

shapeToString :: Shape -> String
shapeToString = case _ of
  ShapeDefault -> "default"
  ShapePill -> "pill"
  ShapeRound -> "round"
  ShapeSquare -> "square"

sizeToString :: Size -> String
sizeToString = case _ of
  SizeMini -> "mini"
  SizeDefault -> "default"
  SizeCompact -> "compact"
  SizeLarge -> "large"

typeToString :: Type -> String
typeToString = case _ of
  TypeSubmit -> "submit"
  TypeReset -> "reset"
  TypeButton -> "button"

derive instance genericKind :: Generic Kind _

instance arbitraryKind :: Arbitrary Kind where
  arbitrary = genericArbitrary

derive instance genericShape :: Generic Shape _

instance arbitraryShape :: Arbitrary Shape where
  arbitrary = genericArbitrary

derive instance genericSize :: Generic Size _

instance arbitrarySize :: Arbitrary Size where
  arbitrary = genericArbitrary

derive instance genericType :: Generic Type _

instance arbitraryType :: Arbitrary Type where
  arbitrary = genericArbitrary
