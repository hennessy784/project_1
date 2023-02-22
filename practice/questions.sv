class matrixx;
rand int a[5][2];
rand int b[5][2];
rand int c[5];
int buff[20];
bit found_odd, found_thirty;
int max, min, odd=0, even=0, big30, size, asize;
constraint c1 {foreach (a[i,j])	a[i][j] inside {[30:100]};
		foreach (b[i,j]) b[i][j] inside {[30:100]};
		foreach (c[i,j]) c[i][j] inside {[0:100]};}
constraint c2 {foreach (a[i,j])
		foreach (b[k,l])
			a[i][j] != b[k][l]; }
function void post_randomize();
	found_odd = 0; found_thirty = 0;
	foreach(a[i,j]) begin buff[i] = a[i][0]; buff[i+5] = a[i][1]; end
	foreach(b[i,j]) begin buff[i+10] = b[i][0]; buff[i+15] = b[i][1]; end
	buff.sort();
	foreach (buff[i]) begin
		min = buff[0];
		max = buff[19];
		if(buff[i]%2 == 0)
			even = buff[i];
		if (buff[i] % 2 != 0) begin
  			if (!found_odd) begin
    			odd = buff[i];
    			found_odd = 1;	end
  		else if (buff[i] < odd) begin
    			odd = buff[i];	end	end
		if(buff[i]>0 && buff[i]<30) begin
			big30 = buff[i];
			found_thirty = 1;	end
		if(found_thirty == 0)
			if(is_prime(buff[i]))
			big30 = buff[i];	
	end
	c[0]=min; c[1]=big30; c[2]=odd; c[3]=even; c[4]=max;
endfunction
function bit is_prime(int num);
if (num < 2)
return 0;
for (int i = 2; i <= num/2; i++) begin
if (num % i == 0)
return 0;
end
return 1;
endfunction
endclass
module example;
matrixx m = new();
initial begin
repeat(10) begin
m.randomize();
$display("%p",m.a);
$display("%p",m.b);
$display("%p",m.c);
$display("-------------------");
end
end
endmodule

/*
class questions;
rand int a[5];
rand int b[5];
rand int c[5];
int buff[10];
int max, min, odd, even;
int big30 = 0;
bit thrty = 0;
constraint c1 {	foreach (a[i])
		a[i] inside {[100:500]};
		foreach (b[j])
		b[j] inside {[100:500]};}
constraint c2 {	foreach (a[i])
		foreach (b[j])
			a[i]!=b[j];
function void post_randomize();
    	foreach (a[i]) buff[i] = a[i];
    	foreach (b[j]) buff[5 + j] = b[j];
	min = buff[0];	max = buff[0];
	buff.sort();
  	foreach (buff[i]) begin
    	if (buff[i] < min) min = buff[i];
    	if (buff[i] > max) max = buff[i];
	c[0] = min;	
	c[4] = max;
	if (buff[i]%2 == 0)
		if(buff[i] > even)
			even = buff[i];
	c[3] = even;
	odd = max;
	if (buff[i]%2 == 1)
		if(buff[i] < odd)
			odd = buff[i];
			c[2] = odd;	
	if(buff[i]>0 && buff[i]<30) begin
	big30 = buff[i];
	thrty = 1;
	end
	if(thrty == 0)
	if(is_prime(buff[i]))
		big30 = buff[i];	end
	c[1] = big30;
	endfunction
	function bit is_prime(int num);
    	int i;
    	if (num < 2)
        return 0;
    	for (i = 2; i <= num/2; i++) begin
        if (num % i == 0)
        return 0;
    	end
    	return 1;
	endfunction
endclass
module example;
questions q1=new();
initial begin
repeat(5) begin
q1.randomize();
$display("A: %p",q1.a);
$display("B: %p",q1.b);
$display("C: %p",q1.c);
$display("-----------------",);
end	end
endmodule

*/
