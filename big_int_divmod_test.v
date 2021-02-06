module biginteger

fn test_divide_mod_big() {
	a := from_str('987654312345678901234567890') or { panic('') }
	b := from_str('98765432109876543210') or { panic('') }

	assert '${a / b}' == '9999999'
	assert '${a % b}' == '90012345579011111100'
}

fn test_divide_mod() {
	divide_mod_inner(0, -3)
	divide_mod_inner(22, 3)
	divide_mod_inner(22, -3)
	divide_mod_inner(-22, 3)
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
