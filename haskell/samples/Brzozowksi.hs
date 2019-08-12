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
  if length (out_1 r) == 1 then (out_1 r)++"*" else "("++(out_1 r)++")*"
out_1 VoidRE = "VoidRE" 
out_1 EmptyRE = "EmptyRE"
-- END:out_1

--START:out_2
out_2 :: Regexp -> String
out_2 n =
 if (delta n)==True
 then (out_1 n)++"(END)"
 else out_1 n
--END:out_2

-- START:out_3
out_3 :: Regexp -> String
out_3 n = 
 let n' = out_2 n
 in case n' of
   "VoidRE" -> "Err"
   _ -> n'
-- END:out_3

-- START:out_4
out_4 :: Regexp -> String
out_4 n = 
 let n' = out_1 n
 in case n' of
   "VoidRE" -> "Err"
   _ -> n'
-- END:out_4

--START:if_empty
if_empty :: Regexp -> Bool
if_empty EmptyRE = True
if_empty VoidRE = False
if_empty n = 
 if (derivative n 'a')==n
    then if (derivative n 'b')==n
           then False
           else (if_empty (derivative n 'b'))
    else if (derivative n 'b')==n
           then (if_empty (derivative n 'a'))
           else (if_empty (derivative n 'a'))||(if_empty (derivative n 'b'))
--END:if_empty

-- START:fsmcal
fsmcal :: Regexp -> [Fsm]
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

--START:fsmcal_re
fsmcal_re :: Regexp -> [Fsm]
fsmcal_re n = 
 if (if_empty n)==True
  then (fsmcal n)++[Fsmsin VoidRE 'a' VoidRE,Fsmsin VoidRE 'b' VoidRE]++[Fsmsin EmptyRE 'a' VoidRE,Fsmsin EmptyRE 'b' VoidRE]
  else (fsmcal n)++[Fsmsin VoidRE 'a' VoidRE,Fsmsin VoidRE 'b' VoidRE]
--END:fsmcal_re

--格式化输出
valueOf :: Fsm -> String
valueOf (Fsmsin a b c)=(out_4 a)++"--"++[b]++"--"++(out_3 c)

listValues :: [Fsm] -> [String]
listValues = map valueOf

printFsm :: Regexp -> IO ()
printFsm = 
 putStrLn . unlines . listValues . fsmcal_re
--格式化输出


--Fsmsin EmptyRE 'a' VoidRE,Fsmsin EmptyRE 'b' VoidRE







