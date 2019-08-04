fizzBuzzHelper :: Integer -> String

fizzBuzzHelper n
　　
       | n `mod` 3 == 0 && n `mod` 5 == 0 = "fizzbuzz"
　　
       | n `mod` 3 == 0 = "fizz"
　　
       | n `mod` 5 == 0 = "buzz"
　　
       | otherwise = ""
