import Data.Functor
import Data.Function
import Data.List
import Debug.Trace

nums :: IO [Int]
nums = getContents <&> lines <&> map read <&> sort

diffs :: [Int] -> Int
diffs nums =
  zipWith (-) nums (0:nums) & foldl (\(d1, d2, d3) d -> 
    case d of
      1 -> (d1+1, d2, d3)
      2 -> (d2, d1+1, d3)
      3 -> (d1, d2, d3+1)
  ) (0, 0, 0) & \(d1, _, d3) -> d1 * (d3 + 1)

count :: [Int] -> Int
count = head . go . (0:) where
  go [_] = [1]
  go (n:l) =
    let cts = go l in
    ( zip l cts & foldr (\(m, ct) sum -> 
        if m > n + 3 then 0 else ct + sum
      ) 0
    ) : cts

-- tail recursive, because I felt like it
count' :: [Int] -> Int
count' = go [(0, 1)] where
    go cts [] = head cts & snd
    go cts (n:l') = go 
      ( (n, foldr (\(m, ct) sum -> 
            if m < n - 3 then 0 else ct + sum
          ) 0 cts
        ) : cts
      ) l'

main :: IO ()
main = do 
  ns <- nums 
  print $ diffs ns
  print $ count ns
  print $ count' ns



