{-# LANGUAGE OverloadedStrings #-}
import Clay
import qualified Clay.Media as Mq

main :: IO ()
main = putCss bodyS

siteW :: Size Abs
siteW = px 800

wide, narrow :: Css -> Css
wide   = query Clay.all [Mq.minWidth siteW]
narrow = query Clay.all [Mq.maxWidth siteW]

bodyS :: Css
bodyS = do
  fonts
  body ? do
          margin nil auto nil auto
          narrow $ width $ pct 100
          wide $ width siteW
          withSerif
          header # "#main-header" ? mainHeader
          aside # "#page-menu" ? pageMenu
          article # "#content" ? articleContent
          footer # "#main-footer" ? mainFooter

fonts :: Css
fonts = do
  importUrl "http://fonts.googleapis.com/css?family=Vollkorn:400,700,400italic,700italic"
  importUrl "http://fonts.googleapis.com/css?family=Ubuntu:400,700,700italic,400italic&subset=latin,latin-ext,greek-ext,greek"

withSerif :: Css
withSerif = fontFamily ["Vollkorn"] [serif]

withSansSerif :: Css
withSansSerif = fontFamily ["Ubuntu"] [sansSerif]

mainHeader :: Css
mainHeader = do
  background darkred
  a ? color white

pageMenu :: Css
pageMenu = do
  ul ? do
    background lightsteelblue
    padding nil nil nil nil
    margin nil nil nil nil
    li ? do
         listStyleType none

firstLetter :: Refinement
firstLetter = ":first-letter"

articleContent :: Css
articleContent = do
  h1 ? fontSize (px 24)
  "#content-body" |> p # firstOfType ? do
    firstLetter & do
                   fontSize (px 50)
                   color darkred
                   verticalAlign textTop
                   float floatLeft

mainFooter :: Css
mainFooter = do
  width $ pct 100
