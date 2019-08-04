-- START:data
data Regexp = CharRE Char
            | ChoiceRE Regexp Regexp
            | SeqRE Rexexp Regexp
            | StarRE Regexp
            | VoidRE
            | EmptyRE
            deriving (Eq, Show)
-- END:data

-- START:delta
delta :: Regexp -> Bool
delta (CharRE c) = False -- (1)
delta (ChoiceRE re_one re_two) = -- (2)
  (delta re_one) || (delta re_two)
delta (SeqRE re_one re_two) =  -- (3)
  (delta re_one) && (delta re_two)
delta (StarRE r) = True -- (4)
delta VoidRE = False -- (5)
delta EmptyRE = True -- (6)
-- END:delta

-- START:deriv
derivative :: Regexp -> Char -> Regexp
derivative (CharRE c) d = -- (7)
  if c == d
    then EmptyRE
    else VoidRE
derivative (SeqRE re_one re_two)) c = -- (8)
  let re_one' = (derivative re_one c)
  in case re_one' of
    VoidRE -> VoidRE
    EmptyRE -> re_two
    _ -> if (delta re_one)
           then (ChoiceRE (SeqRE re_one' re_two) (derivative re_two c))
           else (SeqRE re_one' re_two)
derivative (ChoiceRE re_one re_two) c = -- (9)
  let re_one' = (derivative re_one)
      re_two' = (derivative re_two)
  in case (re_one', re_two') of
    (VoidRE, VoidRE) -> VoidRE
    (VoidRE, nonvoid) -> nonvoid
    (nonvoid, VoidRE) -> nonvoid
    _ -> (ChoiceRE re_one' re_two')
derivative (StarRE r) c = -- (10)
  let r' = derivative r c
  in case r' of
     EmptyRE -> (StarRE r)
     VoidRE -> VoidRE
     _ -> (SeqRE r' (StarRE r))
derivative VoidRE c = VoidRE  -- (11)
derivative EmptyRE c = VoidRE
-- END:deriv
