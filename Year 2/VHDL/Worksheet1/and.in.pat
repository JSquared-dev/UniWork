in vdd B;
in vss B;
in x B;
in y B;
out z B;
# and test
begin
< 0	ns> notxandnoty : 10 00 *;
< +1 	ns> 		: 10 00 *;
< +1 	ns> notxandy	: 10 01 *;
< +1 	ns>  		: 10 01 *;
< +1 	ns> xandnoty 	: 10 10 *;
< +1 	ns>  		: 10 10 *;
< +1 	ns> xandy 	: 10 11 *;
< +1 	ns>  		: 10 11 *;
end;