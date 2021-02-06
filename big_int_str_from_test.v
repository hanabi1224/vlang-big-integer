module biginteger

fn test_from_str_neg_zero() {
	n := from_str('-0') or { panic('') }
	assert n.str() == '0'
}

fn test_from_str_big() {
	str := '23333333333333333333333333333333333333333333333333333333333333333333333333333333333333'
	n := from_str(str) or { panic('') }
	assert n.str() == str
}

fn test_from_str_big_neg() {
	str := '-23333333333333333333333333333333333333333333333333333333333333333333333333333333333333'
	n := from_str(str) or { panic('') }
	assert n.str() == str
}

fn test_from_str() {
	cases := ['0', '288', '-288', '-22', '22', '3', '-3']
	for str in cases {
		n := from_str(str) or { panic('') }
		assert n.str() == str
	}
}
