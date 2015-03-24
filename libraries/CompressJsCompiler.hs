module CompressJsCompiler where

import           Hakyll
import           Control.Applicative ((<$>))
import qualified Data.ByteString.Lazy.Char8 as LB
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import           Text.Jasmine

compressJsCompiler :: Compiler (Item String)
compressJsCompiler = fmap jasmin <$> getResourceString

jasmin :: String -> String
jasmin src = LB.unpack $ minify $ LB.fromChunks [(E.encodeUtf8 $ T.pack src)]
