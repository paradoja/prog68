{-# LANGUAGE OverloadedStrings #-}
import Hakyll

import CompressJsCompiler

main :: IO ()
main = hakyll $ do
    match "templates/*" $
        compile templateCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "js/*.js" $ do
        route   idRoute
        compile compressJsCompiler

    match "index.html" $ do
        route   idRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls
