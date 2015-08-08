double func_pi (double multiplier,int32 passed) {
	if (passed) {return 3.14159265358979323846264338327950288419716939937510582 * multiplier;}
	return (3.14159265358979323846264338327950288419716939937510582);
}

double func_arcsec (double num) {
	int sign = (num > 0) - (num < 0);
	if (num<-1||num>1) {error(5);return 0;}
	return atan(num / sqrt(1 - num * num)) + (sign - 1) * (2 * atan(1));
}

double func_arccsc (double num) {
	int sign = (num > 0) - (num < 0);
	if (num<-1||num>1) {error(5);return 0;}
	return atan(num / sqrt(1 - num * num)) + (sign - 1) * (2 * atan(1));
}

double func_arccot (double num) {return 2 * atan(1) - atan(num);}

double func_sech (double num) {
	if (num>88.02969) {error(5);return 0;}
	if (exp(num) + exp(-num)==0) {error(5);return 0;}
	return 2/ (exp(num) + exp(-num));
}

double func_csch (double num) {
	if (num>88.02969) {error(5);return 0;}
	if (exp(num) - exp(-num)==0) {error(5);return 0;}
	return 2/ (exp(num) - exp(-num));
}

double func_coth (double num) {
	if (num>44.014845) {error(5);return 0;}
	if (2 * exp(num) - 1==0) {error(5);return 0;}
	return 2 * exp(num) - 1;
}

double func_sec (double num) {
	if (cos(num)==0) {error(5);return 0;}
	return 1/cos(num);
}

double func_csc (double num) {
	if (sin(num)==0) {error(5);return 0;}
	return 1/sin(num);
}

double func_cot (double num) {
	if (tan(num)==0) {error(5);return 0;}
	return 1/tan(num);
}