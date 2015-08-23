{- Copyright (C) 2015 Calvin Beck

   Permission is hereby granted, free of charge, to any person
   obtaining a copy of this software and associated documentation files
   (the "Software"), to deal in the Software without restriction,
   including without limitation the rights to use, copy, modify, merge,
   publish, distribute, sublicense, and/or sell copies of the Software,
   and to permit persons to whom the Software is furnished to do so,
   subject to the following conditions:

   The above copyright notice and this permission notice shall be
   included in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
-}

{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE GADTs #-}

module Text.MathForm.MathTypes where

type family Eval a b
type instance Eval Double Integer = Double
type instance Eval Double Double = Double
type instance Eval Integer Double = Double
-- type instance Eval String _ = String
-- type instance Eval _ String = String

-- | Main datatype for keeping track of mathematical expressions.
data MathForm = Mult MathForm MathForm
              | Div MathForm MathForm
              | Frac MathForm MathForm
              | Pow MathForm MathForm
              | Sqrt MathForm
              | Root MathForm MathForm
              | Add MathForm MathForm
              | Sub MathForm MathForm
              | Paren MathForm
              | Negative MathForm
              | Vector [MathForm]
              | Matrix [[MathForm]]
              | Symbol String  -- ^ Identifiers for variables.
              | IntLit Integer
              | FloatLit Double
              deriving (Show)
