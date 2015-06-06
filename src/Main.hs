module Main where
import Control.Concurrent.Async
import Network.HTTP.Conduit
import System.Environment
import qualified Data.ByteString.Lazy as LB

-- Very simple helper function to do a basic get request 

makeUrl :: String -> String
makeUrl u = "https://github.com/" ++ u ++ ".keys"

main :: IO ()
main = do
  usernames <- getArgs 
  let urls = map makeUrl usernames
  keys <- mapConcurrently simpleHttp urls
  mapM_ LB.putStrLn keys
