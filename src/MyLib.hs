module MyLib (someFunc, runChecker) where

import Control.Monad.Writer (execWriter, runWriter)
import qualified Data.HashMap.Lazy as H
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Error.Diagnose
import Error.Diagnose.Compat.Megaparsec
import Error.Diagnose.Diagnostic (printDiagnostic)
import HKF.Ast
import HKF.Check
import HKF.Crawl (runChecker)
import HKF.Error (printErrors)
import HKF.Parser (ParsingContext (MkParsingContext), parseConfig, parseConfigModule)
import Text.Megaparsec (MonadParsec (eof), parseMaybe, parseTest, runParser, runParserT)

someFunc :: IO ()
someFunc = do
  args <- getArgs
  case args of
    root : entry : _ -> do
      diagnostics <- runChecker root (T.pack entry)
      printDiagnostic stderr True True 4 defaultStyle diagnostics
    _ -> print "Unknown incoming args"
