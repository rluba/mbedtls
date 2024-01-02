
time_safe_equal :: (a: string, b: string) -> bool {
    size := Min(a.count, b.count);
    return ((cast(int) (mbedtls_ct_memcmp(a.data, b.data, xx size) == 0)) & cast(int) (a.count == b.count)) > 0;
}

#if OS == .WINDOWS {
	#load "windows.jai";
}
else {
	#load "unix.jai";
	#import "POSIX";
}
