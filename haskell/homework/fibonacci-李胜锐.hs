fib x = if x >= 3 
	then fib(x-1)+fib(x-2)
	else 1