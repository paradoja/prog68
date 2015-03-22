{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

import           Control.Applicative ((<$>))

import           qualified Data.ByteString.Lazy.Char8 as LB
import           qualified Data.Text as T
import           qualified Data.Text.Encoding as E

import           Text.Jasmine

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



compressJsCompiler :: Compiler (Item String)
compressJsCompiler = fmap jasmin <$> getResourceString

jasmin :: String -> String
jasmin src = LB.unpack $ minify $ LB.fromChunks [(E.encodeUtf8 $ T.pack src)]
