--输出一个a/b正则表达式对应的FSM表
import Deriv

-- START:data
data Fsm = Fsmsin Regexp Char Regexp
            deriving (Eq, Show)
-- END:data

-- START:out_1
out_1 :: Regexp -> String
out_1 (CharRE c) = [c]
out_1 (SeqRE re_one re_two) =  (out_1 re_one)++(out_1 re_two)
out_1 (ChoiceRE re_one re_two) = "("++(out_1 re_one)++"|"++(out_1 re_two)++")"
out_1 (StarRE r) = 
  if length (out r) == 1 then (out_1 r)++"*" else "("++(out_1 r)++")*"
out_1 VoidRE = "VoidRE" 
out_1 EmptyRE = "EmptyRE"
-- END:out_1

--START:out_2
out_2 :: Regexp -> String
out_2 n =
 if (delta n)==True
 then (out_1 n)++"(End)"
 else out_1 n
--END:out_2

-- START:out
out :: Regexp -> String
out n = 
 -- let n' = out_2 n--
 let n' = out_1 n
 in case n' of
   "VoidRE" -> "Err"
   _ -> n'
-- END:out

-- START:fsmcal
fsmcal :: Regexp -> [Fsm]
fsmcal (CharRE c) = 
 [Fsmsin (CharRE c) 'a' (derivative (CharRE c) 'a'), Fsmsin (CharRE c) 'b' (derivative (CharRE c) 'b')]
fsmcal VoidRE = [] 
fsmcal EmptyRE = []
fsmcal n =
 if (derivative n 'a')==n
    then if (derivative n 'b')==n
        then [Fsmsin n 'a' (derivative n 'a')]++[Fsmsin n 'b' (derivative n 'b')]
        else [Fsmsin n 'a' (derivative n 'a')]++[Fsmsin n 'b' (derivative n 'b')]++(fsmcal (derivative n 'b'))
    else if (derivative n 'b')==n
        then [Fsmsin n 'a' (derivative n 'a')]++[Fsmsin n 'b' (derivative n 'b')]++(fsmcal (derivative n 'a'))
        else (fsmcal (derivative n 'a'))++(fsmcal (derivative n 'b'))++[Fsmsin n 'a' (derivative n 'a')]++[Fsmsin n 'b' (derivative n 'b')]
-- END:fsmcal

--格式化输出
valueOf :: Fsm -> String
valueOf (Fsmsin a b c)=(out a)++"--"++[b]++"--"++(out c)

listValues :: [Fsm] -> [String]
listValues = map valueOf

printFsm :: Regexp -> IO ()
printFsm = 
 putStrLn . unlines . listValues . fsmcal
--格式化输出










