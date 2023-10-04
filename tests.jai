main :: () {
    test_hmac();
}

test_hmac :: () {
    test_hmac(.SHA256, "secretKey", "Hello HMAC SHA 256!", "40f08b93b298f788109624ad3505882e0467fab1b30a76993a8327097c4f4e45");
    test_hmac(.SHA256, "secret",    "1234567890123456",    "cbf68a78341704e79a4452e4d7bf9a81354f3761cc203ebbe6d94d5e2ab256f3");
    test_hmac(.SHA1,   "secret",    "1234567890123456",    "67c8cbdb58fcf43a52521620a60ee14e6f9f9777");
}

test_hmac :: (digest: mbedtls_md_type_t, key: string, payload: string, expected_result: string) {
    hash_size: int;
    if digest == {
        case .SHA1;  hash_size = 20;
        case .SHA256; hash_size = 32;
        case; assert(false);
    }
    hmac_result: [32] u8;
    ctx: mbedtls_md_context_t;

    mbedtls_md_init(*ctx);
    mbedtls_md_setup(*ctx, mbedtls_md_info_from_type(digest), 1);
    mbedtls_md_hmac_starts(*ctx, key.data, xx key.count);
    mbedtls_md_hmac_update(*ctx, payload.data, xx payload.count);
    mbedtls_md_hmac_finish(*ctx, hmac_result.data);
    mbedtls_md_free(*ctx);

    builder: String_Builder;
    for i: 0..hash_size-1 {
        print_to_builder(*builder, "%", formatInt(hmac_result[i], minimum_digits = 2, base = 16));
    }

    hex_result := builder_to_string(*builder);
    log("Result: %", hex_result);
    assert(hex_result.count == expected_result.count);
    assert(mbedtls_ct_memcmp(hex_result.data, expected_result.data, xx hex_result.count) == 0, "Expected:\n%\nBut got:\n%", expected_result, hex_result);
}

#import "Basic";
#import,file "module.jai";
