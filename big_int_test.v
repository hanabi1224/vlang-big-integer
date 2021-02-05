module biginteger

fn test_zero() {
	n := from_i64(0)
	assert n.str() == '0'
}

fn test_pos() {
	n := from_i64(8)
	assert n.str() == '8'
}

fn test_neg() {
	n := from_i64(-8)
	assert n.str() == '-8'
}

fn test_from_str_neg_zero() {
	n := from_str('-0') or { return }
	assert n.str() == '0'
}

fn test_from_str() {
	cases := ['0', '288', '-288']
	for str in cases {
		n := from_str(str) or { return }
		assert n.str() == str
	}
}

fn test_lshift() {
	a := from_str('12_345_678_901_234_567_890') or { return }
	assert a.lshift(2).str() == '49382715604938271560'
	assert a.lshift(31).str() == '26512143563859841556120862720'
	assert a.lshift(32).str() == '53024287127719683112241725440'
	assert a.lshift(33).str() == '106048574255439366224483450880'
}

fn test_rshift() {
	a := from_str('12345678901234567890') or { return }
	assert a.rshift(2).str() == '3086419725308641972'
	// assert a.rshift(31).str() == '5748904729'
	assert a.rshift(32).str() == '2874452364'
	// assert a.rshift(33).str() == '1437226182'
}

fn test_multiply() {
	a := from_str('12345678901234567890') or { return }
	b := from_str('98765432109876543210') or { return }

	assert '${a * b}' == '1219326311370217952237463801111263526900'
}

fn test_divide_mod_big() {
	a := from_str('987654312345678901234567890') or { return }
	b := from_str('98765432109876543210') or { return }

	assert '${a / b}' == '9999999'
	assert '${a % b}' == '90012345579011111100'
}

fn test_divide_mod() {
	divide_mod_inner(0, -3)
	divide_mod_inner(22, 3)
	divide_mod_inner(-22, 3)
	divide_mod_inner(22, -3)
	divide_mod_inner(-22, -3)
	divide_mod_inner(1, -3)
	divide_mod_inner(-1, 3)
	divide_mod_inner(-1, -3)
}

fn divide_mod_inner(a int, b int) {
	a_big := from_int(a)
	b_big := from_int(b)

	assert '${a_big / b_big}' == '${a / b}'
	assert '${a_big % b_big}' == '${a % b}'
}
