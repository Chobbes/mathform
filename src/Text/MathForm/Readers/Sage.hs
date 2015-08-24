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

module Text.MathForm.Readers.Sage where

import Text.MathForm.MathTypes
import Text.MathForm.Readers.SageTokens
import Text.Parsec
import Text.Parsec.Expr
import Text.Parsec.Text
import Control.Monad
import Control.Monad.Identity
import qualified Data.Text as T


parseSage :: Parser MathForm
parseSage = buildExpressionParser table term


term :: Parser MathForm
term = parens parseSage
       <|> fmap (either IntLit FloatLit) naturalOrFloat
       <|> liftM Symbol identifier


-- | https://hackage.haskell.org/package/parsec-3.1.9/docs/Text-Parsec-Expr.html
-- is pretty much exactly what we need here.
table :: OperatorTable T.Text st Identity MathForm
table = [ [binary "**" Pow AssocLeft, binary "^" Pow AssocLeft]
        , [prefix "-" Neg, prefix "+" Pos]
        , [binary "*" Mult AssocLeft, binary "/" Div AssocLeft]
        , [binary "+" Plus AssocLeft, binary "-" Sub AssocLeft]
        ]


binary  name fun = Infix (do { reservedOp name; return fun })
prefix  name fun = Prefix (do { reservedOp name; return fun })
postfix name fun = Postfix (do { reservedOp name; return fun })
