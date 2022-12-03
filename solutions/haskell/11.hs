import Data.Function
import qualified Data.List as List
import qualified Data.Map as Map
import Data.Functor

type Pos = (Int, Int)
type Grid = Map Pos Bool

parse :: String -> Grid
parse s =
  lines s & zip [0..] & List.foldl' (\acc (i, row) ->
    zip [0..] row
    & List.foldl' (\m (j, c) -> ins (i, j) c m) acc 
  ) empty
  where
    ins k '#' = Map.insert k True
    ins k 'L' = Map.insert k False
    ins _ '.' = id

adj :: Grid -> [(Pos, Pos)]
adj g =
  Map.keys g >>= \(i, j) ->
    [(1, 0), (1, 1), (0, 1), (-1, 0)]
    & List.mapMaybe (\(di, dj) -> 
        zip [i,i+di..] [j,j+dj..]
        & List.foldr (\(i', j') -> rest
            
          ) None
      )

main :: IO ()
main = getContents <&> parse >>= print
