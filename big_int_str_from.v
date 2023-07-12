module biginteger

pub fn from_str(str string) !BigInteger {
	base := ten
	// Validate with regex, allowing _ and ,
	char_code_0 := '0'[0]
	char_code_underscore := '_'[0]
	char_code_comma := ','[0]
	char_code_minus := '-'[0]
	mut digits := []u8{}
	negative := if str[0] == char_code_minus { true } else { false }
	digits_str := if negative { str[1..] } else { str }
	for char_code in digits_str {
		if char_code >= char_code_0 && char_code < char_code_0 + 10 {
			num := char_code - char_code_0
			digits << num
		} else if char_code == char_code_underscore || char_code == char_code_comma {
			// do nothing
		} else {
			return error('Error parsing number: $str')
		}
	}

	mut num := zero
	mut times := one
	for i := digits.len - 1; i >= 0; i-- {
		d := digits[i]
		if negative {
			num = num - from_int(d) * times
		} else {
			num = num + from_int(d) * times
		}

		times = times * base
	}

	return num
}
