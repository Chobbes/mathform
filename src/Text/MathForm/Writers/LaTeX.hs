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

module Text.MathForm.Writers.LaTeX (writeLaTeX) where

import Text.MathForm.MathTypes

writeLaTeX :: MathForm -> String
writeLaTeX (Symbol str) = str
writeLaTeX (IntLit int) = show int
writeLaTeX (FloatLit float) = show float
writeLaTeX (Paren a) = "(" ++ writeLaTeX a ++ ")"
writeLaTeX (Mult a b) = writeLaTeX a ++ " \\cdot " ++ writeLaTeX b
writeLaTeX (Div a b) = writeLaTeX a ++ " / " ++ writeLaTeX b
writeLaTeX (Frac a b) = "\\frac{" ++ writeLaTeX a ++ "}" ++ "{" ++ writeLaTeX b ++ "}"
writeLaTeX (Pow a b) = "{" ++ writeLaTeX a ++ "}^{" ++ writeLaTeX b ++ "}"
writeLaTeX (Sqrt a) = "\\sqrt{" ++ writeLaTeX a ++ "}"
writeLaTeX (Root a b) = "\\sqrt[" ++ writeLaTeX a ++ "]{" ++ writeLaTeX b ++ "}"
writeLaTeX (Plus a b) = writeLaTeX a ++ " + " ++ writeLaTeX b
writeLaTeX (Sub a b) = writeLaTeX a ++ " - " ++ writeLaTeX b
writeLaTeX (Neg a) = "-" ++ writeLaTeX a
