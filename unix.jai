//
// This file was auto-generated using the following command:
//
// jai generate.jai
//



MBEDTLS_VERSION_MAJOR :: 3;
MBEDTLS_VERSION_MINOR :: 4;
MBEDTLS_VERSION_PATCH :: 1;

MBEDTLS_VERSION_NUMBER :: 0x03040100;
MBEDTLS_VERSION_STRING :: "3.4.1";
MBEDTLS_VERSION_STRING_FULL :: "mbed TLS 3.4.1";

MBEDTLS_SSL_DTLS_CONNECTION_ID_COMPAT :: 0;

MBEDTLS_SSL_MAX_EARLY_DATA_SIZE :: 1024;

MBEDTLS_SSL_TLS1_3_TICKET_AGE_TOLERANCE :: 6000;

MBEDTLS_SSL_TLS1_3_TICKET_NONCE_LENGTH :: 32;

MBEDTLS_SSL_TLS1_3_DEFAULT_NEW_SESSION_TICKETS :: 1;

PSA_HAVE_FULL_ECDSA :: 1;

PSA_HAVE_FULL_JPAKE :: 1;

MBEDTLS_AES_ENCRYPT :: 1;
MBEDTLS_AES_DECRYPT :: 0;

MBEDTLS_ERR_AES_INVALID_KEY_LENGTH :: -0x0020;

MBEDTLS_ERR_AES_INVALID_INPUT_LENGTH :: -0x0022;

MBEDTLS_ERR_AES_BAD_INPUT_DATA :: -0x0021;

MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE :: -0x5080;

MBEDTLS_ERR_MD_BAD_INPUT_DATA :: -0x5100;

MBEDTLS_ERR_MD_ALLOC_FAILED :: -0x5180;

MBEDTLS_ERR_MD_FILE_IO_ERROR :: -0x5200;

MBEDTLS_MD_MAX_SIZE :: 64;

MBEDTLS_MD_MAX_BLOCK_SIZE :: 128;

/*
* Avoid warning from -pedantic. This is a convenient place for this
* workaround since this is included by every single file before the
* #if defined(MBEDTLS_xxx_C) that results in empty translation units.
*/
mbedtls_iso_c_forbids_empty_translation_units :: s32;

mbedtls_time_t :: time_t;

/**
* \brief       Securely zeroize a buffer
*
*              The function is meant to wipe the data contained in a buffer so
*              that it can no longer be recovered even if the program memory
*              is later compromised. Call this function on sensitive data
*              stored on the stack before returning from a function, and on
*              sensitive data stored on the heap before freeing the heap
*              object.
*
*              It is extremely difficult to guarantee that calls to
*              mbedtls_platform_zeroize() are not removed by aggressive
*              compiler optimizations in a portable way. For this reason, Mbed
*              TLS provides the configuration option
*              MBEDTLS_PLATFORM_ZEROIZE_ALT, which allows users to configure
*              mbedtls_platform_zeroize() to use a suitable implementation for
*              their platform and needs
*
* \param buf   Buffer to be zeroized
* \param len   Length of the buffer in bytes
*
*/
mbedtls_platform_zeroize :: (buf: *void, len: u64) -> void #foreign libmbedcrypto;

/**
* \brief      Platform-specific implementation of gmtime_r()
*
*             The function is a thread-safe abstraction that behaves
*             similarly to the gmtime_r() function from Unix/POSIX.
*
*             Mbed TLS will try to identify the underlying platform and
*             make use of an appropriate underlying implementation (e.g.
*             gmtime_r() for POSIX and gmtime_s() for Windows). If this is
*             not possible, then gmtime() will be used. In this case, calls
*             from the library to gmtime() will be guarded by the mutex
*             mbedtls_threading_gmtime_mutex if MBEDTLS_THREADING_C is
*             enabled. It is recommended that calls from outside the library
*             are also guarded by this mutex.
*
*             If MBEDTLS_PLATFORM_GMTIME_R_ALT is defined, then Mbed TLS will
*             unconditionally use the alternative implementation for
*             mbedtls_platform_gmtime_r() supplied by the user at compile time.
*
* \param tt     Pointer to an object containing time (in seconds) since the
*               epoch to be converted
* \param tm_buf Pointer to an object where the results will be stored
*
* \return      Pointer to an object of type struct tm on success, otherwise
*              NULL
*/
mbedtls_platform_gmtime_r :: (tt: *mbedtls_time_t, tm_buf: *tm) -> *tm #foreign libmbedcrypto;

/**
* \brief The AES context-type definition.
*/
mbedtls_aes_context :: struct {
    private_nr:        s32;
    private_rk_offset: u64;

    private_buf:       [68] u32;
}

/**
* \brief The AES XTS context-type definition.
*/
mbedtls_aes_xts_context :: struct {
    private_crypt: mbedtls_aes_context;

    private_tweak: mbedtls_aes_context;
}

/**
* \brief          This function initializes the specified AES context.
*
*                 It must be the first API called before using
*                 the context.
*
* \param ctx      The AES context to initialize. This must not be \c NULL.
*/
mbedtls_aes_init :: (ctx: *mbedtls_aes_context) -> void #foreign libmbedcrypto;

/**
* \brief          This function releases and clears the specified AES context.
*
* \param ctx      The AES context to clear.
*                 If this is \c NULL, this function does nothing.
*                 Otherwise, the context must have been at least initialized.
*/
mbedtls_aes_free :: (ctx: *mbedtls_aes_context) -> void #foreign libmbedcrypto;

/**
* \brief          This function initializes the specified AES XTS context.
*
*                 It must be the first API called before using
*                 the context.
*
* \param ctx      The AES XTS context to initialize. This must not be \c NULL.
*/
mbedtls_aes_xts_init :: (ctx: *mbedtls_aes_xts_context) -> void #foreign libmbedcrypto;

/**
* \brief          This function releases and clears the specified AES XTS context.
*
* \param ctx      The AES XTS context to clear.
*                 If this is \c NULL, this function does nothing.
*                 Otherwise, the context must have been at least initialized.
*/
mbedtls_aes_xts_free :: (ctx: *mbedtls_aes_xts_context) -> void #foreign libmbedcrypto;

/**
* \brief          This function sets the encryption key.
*
* \param ctx      The AES context to which the key should be bound.
*                 It must be initialized.
* \param key      The encryption key.
*                 This must be a readable buffer of size \p keybits bits.
* \param keybits  The size of data passed in bits. Valid options are:
*                 <ul><li>128 bits</li>
*                 <li>192 bits</li>
*                 <li>256 bits</li></ul>
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_AES_INVALID_KEY_LENGTH on failure.
*/
mbedtls_aes_setkey_enc :: (ctx: *mbedtls_aes_context, key: *u8, keybits: u32) -> s32 #foreign libmbedcrypto;

/**
* \brief          This function sets the decryption key.
*
* \param ctx      The AES context to which the key should be bound.
*                 It must be initialized.
* \param key      The decryption key.
*                 This must be a readable buffer of size \p keybits bits.
* \param keybits  The size of data passed. Valid options are:
*                 <ul><li>128 bits</li>
*                 <li>192 bits</li>
*                 <li>256 bits</li></ul>
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_AES_INVALID_KEY_LENGTH on failure.
*/
mbedtls_aes_setkey_dec :: (ctx: *mbedtls_aes_context, key: *u8, keybits: u32) -> s32 #foreign libmbedcrypto;

/**
* \brief          This function prepares an XTS context for encryption and
*                 sets the encryption key.
*
* \param ctx      The AES XTS context to which the key should be bound.
*                 It must be initialized.
* \param key      The encryption key. This is comprised of the XTS key1
*                 concatenated with the XTS key2.
*                 This must be a readable buffer of size \p keybits bits.
* \param keybits  The size of \p key passed in bits. Valid options are:
*                 <ul><li>256 bits (each of key1 and key2 is a 128-bit key)</li>
*                 <li>512 bits (each of key1 and key2 is a 256-bit key)</li></ul>
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_AES_INVALID_KEY_LENGTH on failure.
*/
mbedtls_aes_xts_setkey_enc :: (ctx: *mbedtls_aes_xts_context, key: *u8, keybits: u32) -> s32 #foreign libmbedcrypto;

/**
* \brief          This function prepares an XTS context for decryption and
*                 sets the decryption key.
*
* \param ctx      The AES XTS context to which the key should be bound.
*                 It must be initialized.
* \param key      The decryption key. This is comprised of the XTS key1
*                 concatenated with the XTS key2.
*                 This must be a readable buffer of size \p keybits bits.
* \param keybits  The size of \p key passed in bits. Valid options are:
*                 <ul><li>256 bits (each of key1 and key2 is a 128-bit key)</li>
*                 <li>512 bits (each of key1 and key2 is a 256-bit key)</li></ul>
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_AES_INVALID_KEY_LENGTH on failure.
*/
mbedtls_aes_xts_setkey_dec :: (ctx: *mbedtls_aes_xts_context, key: *u8, keybits: u32) -> s32 #foreign libmbedcrypto;

/**
* \brief          This function performs an AES single-block encryption or
*                 decryption operation.
*
*                 It performs the operation defined in the \p mode parameter
*                 (encrypt or decrypt), on the input data buffer defined in
*                 the \p input parameter.
*
*                 mbedtls_aes_init(), and either mbedtls_aes_setkey_enc() or
*                 mbedtls_aes_setkey_dec() must be called before the first
*                 call to this API with the same context.
*
* \param ctx      The AES context to use for encryption or decryption.
*                 It must be initialized and bound to a key.
* \param mode     The AES operation: #MBEDTLS_AES_ENCRYPT or
*                 #MBEDTLS_AES_DECRYPT.
* \param input    The buffer holding the input data.
*                 It must be readable and at least \c 16 Bytes long.
* \param output   The buffer where the output data will be written.
*                 It must be writeable and at least \c 16 Bytes long.

* \return         \c 0 on success.
*/
mbedtls_aes_crypt_ecb :: (ctx: *mbedtls_aes_context, mode: s32, input: *[16] u8, output: *[16] u8) -> s32 #foreign libmbedcrypto;

/**
* \brief  This function performs an AES-CBC encryption or decryption operation
*         on full blocks.
*
*         It performs the operation defined in the \p mode
*         parameter (encrypt/decrypt), on the input data buffer defined in
*         the \p input parameter.
*
*         It can be called as many times as needed, until all the input
*         data is processed. mbedtls_aes_init(), and either
*         mbedtls_aes_setkey_enc() or mbedtls_aes_setkey_dec() must be called
*         before the first call to this API with the same context.
*
* \note   This function operates on full blocks, that is, the input size
*         must be a multiple of the AES block size of \c 16 Bytes.
*
* \note   Upon exit, the content of the IV is updated so that you can
*         call the same function again on the next
*         block(s) of data and get the same result as if it was
*         encrypted in one call. This allows a "streaming" usage.
*         If you need to retain the contents of the IV, you should
*         either save it manually or use the cipher module instead.
*
*
* \param ctx      The AES context to use for encryption or decryption.
*                 It must be initialized and bound to a key.
* \param mode     The AES operation: #MBEDTLS_AES_ENCRYPT or
*                 #MBEDTLS_AES_DECRYPT.
* \param length   The length of the input data in Bytes. This must be a
*                 multiple of the block size (\c 16 Bytes).
* \param iv       Initialization vector (updated after use).
*                 It must be a readable and writeable buffer of \c 16 Bytes.
* \param input    The buffer holding the input data.
*                 It must be readable and of size \p length Bytes.
* \param output   The buffer holding the output data.
*                 It must be writeable and of size \p length Bytes.
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_AES_INVALID_INPUT_LENGTH
*                 on failure.
*/
mbedtls_aes_crypt_cbc :: (ctx: *mbedtls_aes_context, mode: s32, length: u64, iv: *[16] u8, input: *u8, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief      This function performs an AES-XTS encryption or decryption
*             operation for an entire XTS data unit.
*
*             AES-XTS encrypts or decrypts blocks based on their location as
*             defined by a data unit number. The data unit number must be
*             provided by \p data_unit.
*
*             NIST SP 800-38E limits the maximum size of a data unit to 2^20
*             AES blocks. If the data unit is larger than this, this function
*             returns #MBEDTLS_ERR_AES_INVALID_INPUT_LENGTH.
*
* \param ctx          The AES XTS context to use for AES XTS operations.
*                     It must be initialized and bound to a key.
* \param mode         The AES operation: #MBEDTLS_AES_ENCRYPT or
*                     #MBEDTLS_AES_DECRYPT.
* \param length       The length of a data unit in Bytes. This can be any
*                     length between 16 bytes and 2^24 bytes inclusive
*                     (between 1 and 2^20 block cipher blocks).
* \param data_unit    The address of the data unit encoded as an array of 16
*                     bytes in little-endian format. For disk encryption, this
*                     is typically the index of the block device sector that
*                     contains the data.
* \param input        The buffer holding the input data (which is an entire
*                     data unit). This function reads \p length Bytes from \p
*                     input.
* \param output       The buffer holding the output data (which is an entire
*                     data unit). This function writes \p length Bytes to \p
*                     output.
*
* \return             \c 0 on success.
* \return             #MBEDTLS_ERR_AES_INVALID_INPUT_LENGTH if \p length is
*                     smaller than an AES block in size (16 Bytes) or if \p
*                     length is larger than 2^20 blocks (16 MiB).
*/
mbedtls_aes_crypt_xts :: (ctx: *mbedtls_aes_xts_context, mode: s32, length: u64, data_unit: *[16] u8, input: *u8, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief This function performs an AES-CFB128 encryption or decryption
*        operation.
*
*        It performs the operation defined in the \p mode
*        parameter (encrypt or decrypt), on the input data buffer
*        defined in the \p input parameter.
*
*        For CFB, you must set up the context with mbedtls_aes_setkey_enc(),
*        regardless of whether you are performing an encryption or decryption
*        operation, that is, regardless of the \p mode parameter. This is
*        because CFB mode uses the same key schedule for encryption and
*        decryption.
*
* \note  Upon exit, the content of the IV is updated so that you can
*        call the same function again on the next
*        block(s) of data and get the same result as if it was
*        encrypted in one call. This allows a "streaming" usage.
*        If you need to retain the contents of the
*        IV, you must either save it manually or use the cipher
*        module instead.
*
*
* \param ctx      The AES context to use for encryption or decryption.
*                 It must be initialized and bound to a key.
* \param mode     The AES operation: #MBEDTLS_AES_ENCRYPT or
*                 #MBEDTLS_AES_DECRYPT.
* \param length   The length of the input data in Bytes.
* \param iv_off   The offset in IV (updated after use).
*                 It must point to a valid \c size_t.
* \param iv       The initialization vector (updated after use).
*                 It must be a readable and writeable buffer of \c 16 Bytes.
* \param input    The buffer holding the input data.
*                 It must be readable and of size \p length Bytes.
* \param output   The buffer holding the output data.
*                 It must be writeable and of size \p length Bytes.
*
* \return         \c 0 on success.
*/
mbedtls_aes_crypt_cfb128 :: (ctx: *mbedtls_aes_context, mode: s32, length: u64, iv_off: *u64, iv: *[16] u8, input: *u8, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief This function performs an AES-CFB8 encryption or decryption
*        operation.
*
*        It performs the operation defined in the \p mode
*        parameter (encrypt/decrypt), on the input data buffer defined
*        in the \p input parameter.
*
*        Due to the nature of CFB, you must use the same key schedule for
*        both encryption and decryption operations. Therefore, you must
*        use the context initialized with mbedtls_aes_setkey_enc() for
*        both #MBEDTLS_AES_ENCRYPT and #MBEDTLS_AES_DECRYPT.
*
* \note  Upon exit, the content of the IV is updated so that you can
*        call the same function again on the next
*        block(s) of data and get the same result as if it was
*        encrypted in one call. This allows a "streaming" usage.
*        If you need to retain the contents of the
*        IV, you should either save it manually or use the cipher
*        module instead.
*
*
* \param ctx      The AES context to use for encryption or decryption.
*                 It must be initialized and bound to a key.
* \param mode     The AES operation: #MBEDTLS_AES_ENCRYPT or
*                 #MBEDTLS_AES_DECRYPT
* \param length   The length of the input data.
* \param iv       The initialization vector (updated after use).
*                 It must be a readable and writeable buffer of \c 16 Bytes.
* \param input    The buffer holding the input data.
*                 It must be readable and of size \p length Bytes.
* \param output   The buffer holding the output data.
*                 It must be writeable and of size \p length Bytes.
*
* \return         \c 0 on success.
*/
mbedtls_aes_crypt_cfb8 :: (ctx: *mbedtls_aes_context, mode: s32, length: u64, iv: *[16] u8, input: *u8, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief       This function performs an AES-OFB (Output Feedback Mode)
*              encryption or decryption operation.
*
*              For OFB, you must set up the context with
*              mbedtls_aes_setkey_enc(), regardless of whether you are
*              performing an encryption or decryption operation. This is
*              because OFB mode uses the same key schedule for encryption and
*              decryption.
*
*              The OFB operation is identical for encryption or decryption,
*              therefore no operation mode needs to be specified.
*
* \note        Upon exit, the content of iv, the Initialisation Vector, is
*              updated so that you can call the same function again on the next
*              block(s) of data and get the same result as if it was encrypted
*              in one call. This allows a "streaming" usage, by initialising
*              iv_off to 0 before the first call, and preserving its value
*              between calls.
*
*              For non-streaming use, the iv should be initialised on each call
*              to a unique value, and iv_off set to 0 on each call.
*
*              If you need to retain the contents of the initialisation vector,
*              you must either save it manually or use the cipher module
*              instead.
*
* \warning     For the OFB mode, the initialisation vector must be unique
*              every encryption operation. Reuse of an initialisation vector
*              will compromise security.
*
* \param ctx      The AES context to use for encryption or decryption.
*                 It must be initialized and bound to a key.
* \param length   The length of the input data.
* \param iv_off   The offset in IV (updated after use).
*                 It must point to a valid \c size_t.
* \param iv       The initialization vector (updated after use).
*                 It must be a readable and writeable buffer of \c 16 Bytes.
* \param input    The buffer holding the input data.
*                 It must be readable and of size \p length Bytes.
* \param output   The buffer holding the output data.
*                 It must be writeable and of size \p length Bytes.
*
* \return         \c 0 on success.
*/
mbedtls_aes_crypt_ofb :: (ctx: *mbedtls_aes_context, length: u64, iv_off: *u64, iv: *[16] u8, input: *u8, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief      This function performs an AES-CTR encryption or decryption
*             operation.
*
*             Due to the nature of CTR, you must use the same key schedule
*             for both encryption and decryption operations. Therefore, you
*             must use the context initialized with mbedtls_aes_setkey_enc()
*             for both #MBEDTLS_AES_ENCRYPT and #MBEDTLS_AES_DECRYPT.
*
* \warning    You must never reuse a nonce value with the same key. Doing so
*             would void the encryption for the two messages encrypted with
*             the same nonce and key.
*
*             There are two common strategies for managing nonces with CTR:
*
*             1. You can handle everything as a single message processed over
*             successive calls to this function. In that case, you want to
*             set \p nonce_counter and \p nc_off to 0 for the first call, and
*             then preserve the values of \p nonce_counter, \p nc_off and \p
*             stream_block across calls to this function as they will be
*             updated by this function.
*
*             With this strategy, you must not encrypt more than 2**128
*             blocks of data with the same key.
*
*             2. You can encrypt separate messages by dividing the \p
*             nonce_counter buffer in two areas: the first one used for a
*             per-message nonce, handled by yourself, and the second one
*             updated by this function internally.
*
*             For example, you might reserve the first 12 bytes for the
*             per-message nonce, and the last 4 bytes for internal use. In that
*             case, before calling this function on a new message you need to
*             set the first 12 bytes of \p nonce_counter to your chosen nonce
*             value, the last 4 to 0, and \p nc_off to 0 (which will cause \p
*             stream_block to be ignored). That way, you can encrypt at most
*             2**96 messages of up to 2**32 blocks each with the same key.
*
*             The per-message nonce (or information sufficient to reconstruct
*             it) needs to be communicated with the ciphertext and must be unique.
*             The recommended way to ensure uniqueness is to use a message
*             counter. An alternative is to generate random nonces, but this
*             limits the number of messages that can be securely encrypted:
*             for example, with 96-bit random nonces, you should not encrypt
*             more than 2**32 messages with the same key.
*
*             Note that for both strategies, sizes are measured in blocks and
*             that an AES block is 16 bytes.
*
* \warning    Upon return, \p stream_block contains sensitive data. Its
*             content must not be written to insecure storage and should be
*             securely discarded as soon as it's no longer needed.
*
* \param ctx              The AES context to use for encryption or decryption.
*                         It must be initialized and bound to a key.
* \param length           The length of the input data.
* \param nc_off           The offset in the current \p stream_block, for
*                         resuming within the current cipher stream. The
*                         offset pointer should be 0 at the start of a stream.
*                         It must point to a valid \c size_t.
* \param nonce_counter    The 128-bit nonce and counter.
*                         It must be a readable-writeable buffer of \c 16 Bytes.
* \param stream_block     The saved stream block for resuming. This is
*                         overwritten by the function.
*                         It must be a readable-writeable buffer of \c 16 Bytes.
* \param input            The buffer holding the input data.
*                         It must be readable and of size \p length Bytes.
* \param output           The buffer holding the output data.
*                         It must be writeable and of size \p length Bytes.
*
* \return                 \c 0 on success.
*/
mbedtls_aes_crypt_ctr :: (ctx: *mbedtls_aes_context, length: u64, nc_off: *u64, nonce_counter: *[16] u8, stream_block: *[16] u8, input: *u8, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief           Internal AES block encryption function. This is only
*                  exposed to allow overriding it using
*                  \c MBEDTLS_AES_ENCRYPT_ALT.
*
* \param ctx       The AES context to use for encryption.
* \param input     The plaintext block.
* \param output    The output (ciphertext) block.
*
* \return          \c 0 on success.
*/
mbedtls_internal_aes_encrypt :: (ctx: *mbedtls_aes_context, input: *[16] u8, output: *[16] u8) -> s32 #foreign libmbedcrypto;

/**
* \brief           Internal AES block decryption function. This is only
*                  exposed to allow overriding it using see
*                  \c MBEDTLS_AES_DECRYPT_ALT.
*
* \param ctx       The AES context to use for decryption.
* \param input     The ciphertext block.
* \param output    The output (plaintext) block.
*
* \return          \c 0 on success.
*/
mbedtls_internal_aes_decrypt :: (ctx: *mbedtls_aes_context, input: *[16] u8, output: *[16] u8) -> s32 #foreign libmbedcrypto;

/**
* \brief          Checkup routine.
*
* \return         \c 0 on success.
* \return         \c 1 on failure.
*/
mbedtls_aes_self_test :: (verbose: s32) -> s32 #foreign libmbedcrypto;

/**
* \brief     Supported message digests.
*
* \warning   MD5 and SHA-1 are considered weak message digests and
*            their use constitutes a security risk. We recommend considering
*            stronger message digests instead.
*
*/
mbedtls_md_type_t :: enum u32 {
    NONE      :: 0;
    MD5       :: 1;
    SHA1      :: 2;
    SHA224    :: 3;
    SHA256    :: 4;
    SHA384    :: 5;
    SHA512    :: 6;
    RIPEMD160 :: 7;
}

mbedtls_md_info_t :: struct {}

/**
* Used internally to indicate whether a context uses legacy or PSA.
*
* Internal use only.
*/
mbedtls_md_engine_t :: enum u32 {
    LEGACY :: 0;
    PSA    :: 1;
}

/**
* The generic message-digest context.
*/
mbedtls_md_context_t :: struct {
    private_md_info:  *mbedtls_md_info_t;

    private_md_ctx:   *void;

    private_hmac_ctx: *void;
}

/**
* \brief           This function returns the message-digest information
*                  associated with the given digest type.
*
* \param md_type   The type of digest to search for.
*
* \return          The message-digest information associated with \p md_type.
* \return          NULL if the associated message-digest information is not found.
*/
mbedtls_md_info_from_type :: (md_type: mbedtls_md_type_t) -> *mbedtls_md_info_t #foreign libmbedcrypto;

/**
* \brief           This function initializes a message-digest context without
*                  binding it to a particular message-digest algorithm.
*
*                  This function should always be called first. It prepares the
*                  context for mbedtls_md_setup() for binding it to a
*                  message-digest algorithm.
*/
mbedtls_md_init :: (ctx: *mbedtls_md_context_t) -> void #foreign libmbedcrypto;

/**
* \brief           This function clears the internal structure of \p ctx and
*                  frees any embedded internal structure, but does not free
*                  \p ctx itself.
*
*                  If you have called mbedtls_md_setup() on \p ctx, you must
*                  call mbedtls_md_free() when you are no longer using the
*                  context.
*                  Calling this function if you have previously
*                  called mbedtls_md_init() and nothing else is optional.
*                  You must not call this function if you have not called
*                  mbedtls_md_init().
*/
mbedtls_md_free :: (ctx: *mbedtls_md_context_t) -> void #foreign libmbedcrypto;

/**
* \brief           This function selects the message digest algorithm to use,
*                  and allocates internal structures.
*
*                  It should be called after mbedtls_md_init() or
*                  mbedtls_md_free(). Makes it necessary to call
*                  mbedtls_md_free() later.
*
* \param ctx       The context to set up.
* \param md_info   The information structure of the message-digest algorithm
*                  to use.
* \param hmac      Defines if HMAC is used. 0: HMAC is not used (saves some memory),
*                  or non-zero: HMAC is used with this context.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
* \return          #MBEDTLS_ERR_MD_ALLOC_FAILED on memory-allocation failure.
*/
mbedtls_md_setup :: (ctx: *mbedtls_md_context_t, md_info: *mbedtls_md_info_t, hmac: s32) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function clones the state of a message-digest
*                  context.
*
* \note            You must call mbedtls_md_setup() on \c dst before calling
*                  this function.
*
* \note            The two contexts must have the same type,
*                  for example, both are SHA-256.
*
* \warning         This function clones the message-digest state, not the
*                  HMAC state.
*
* \param dst       The destination context.
* \param src       The context to be cloned.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification failure.
* \return          #MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE if both contexts are
*                  not using the same engine. This can be avoided by moving
*                  the call to psa_crypto_init() before the first call to
*                  mbedtls_md_setup().
*/
mbedtls_md_clone :: (dst: *mbedtls_md_context_t, src: *mbedtls_md_context_t) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function extracts the message-digest size from the
*                  message-digest information structure.
*
* \param md_info   The information structure of the message-digest algorithm
*                  to use.
*
* \return          The size of the message-digest output in Bytes.
*/
mbedtls_md_get_size :: (md_info: *mbedtls_md_info_t) -> u8 #foreign libmbedcrypto;

/**
* \brief           This function extracts the message-digest type from the
*                  message-digest information structure.
*
* \param md_info   The information structure of the message-digest algorithm
*                  to use.
*
* \return          The type of the message digest.
*/
mbedtls_md_get_type :: (md_info: *mbedtls_md_info_t) -> mbedtls_md_type_t #foreign libmbedcrypto;

/**
* \brief           This function starts a message-digest computation.
*
*                  You must call this function after setting up the context
*                  with mbedtls_md_setup(), and before passing data with
*                  mbedtls_md_update().
*
* \param ctx       The generic message-digest context.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
*/
mbedtls_md_starts :: (ctx: *mbedtls_md_context_t) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function feeds an input buffer into an ongoing
*                  message-digest computation.
*
*                  You must call mbedtls_md_starts() before calling this
*                  function. You may call this function multiple times.
*                  Afterwards, call mbedtls_md_finish().
*
* \param ctx       The generic message-digest context.
* \param input     The buffer holding the input data.
* \param ilen      The length of the input data.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
*/
mbedtls_md_update :: (ctx: *mbedtls_md_context_t, input: *u8, ilen: u64) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function finishes the digest operation,
*                  and writes the result to the output buffer.
*
*                  Call this function after a call to mbedtls_md_starts(),
*                  followed by any number of calls to mbedtls_md_update().
*                  Afterwards, you may either clear the context with
*                  mbedtls_md_free(), or call mbedtls_md_starts() to reuse
*                  the context for another digest operation with the same
*                  algorithm.
*
* \param ctx       The generic message-digest context.
* \param output    The buffer for the generic message-digest checksum result.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
*/
mbedtls_md_finish :: (ctx: *mbedtls_md_context_t, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief          This function calculates the message-digest of a buffer,
*                 with respect to a configurable message-digest algorithm
*                 in a single call.
*
*                 The result is calculated as
*                 Output = message_digest(input buffer).
*
* \param md_info  The information structure of the message-digest algorithm
*                 to use.
* \param input    The buffer holding the data.
* \param ilen     The length of the input data.
* \param output   The generic message-digest checksum result.
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                 failure.
*/
mbedtls_md :: (md_info: *mbedtls_md_info_t, input: *u8, ilen: u64, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function returns the list of digests supported by the
*                  generic digest module.
*
* \note            The list starts with the strongest available hashes.
*
* \return          A statically allocated array of digests. Each element
*                  in the returned list is an integer belonging to the
*                  message-digest enumeration #mbedtls_md_type_t.
*                  The last entry is 0.
*/
mbedtls_md_list :: () -> *s32 #foreign libmbedcrypto;

/**
* \brief           This function returns the message-digest information
*                  associated with the given digest name.
*
* \param md_name   The name of the digest to search for.
*
* \return          The message-digest information associated with \p md_name.
* \return          NULL if the associated message-digest information is not found.
*/
mbedtls_md_info_from_string :: (md_name: *u8) -> *mbedtls_md_info_t #foreign libmbedcrypto;

/**
* \brief           This function extracts the message-digest name from the
*                  message-digest information structure.
*
* \param md_info   The information structure of the message-digest algorithm
*                  to use.
*
* \return          The name of the message digest.
*/
mbedtls_md_get_name :: (md_info: *mbedtls_md_info_t) -> *u8 #foreign libmbedcrypto;

/**
* \brief           This function returns the message-digest information
*                  from the given context.
*
* \param ctx       The context from which to extract the information.
*                  This must be initialized (or \c NULL).
*
* \return          The message-digest information associated with \p ctx.
* \return          \c NULL if \p ctx is \c NULL.
*/
mbedtls_md_info_from_ctx :: (ctx: *mbedtls_md_context_t) -> *mbedtls_md_info_t #foreign libmbedcrypto;

/**
* \brief          This function calculates the message-digest checksum
*                 result of the contents of the provided file.
*
*                 The result is calculated as
*                 Output = message_digest(file contents).
*
* \param md_info  The information structure of the message-digest algorithm
*                 to use.
* \param path     The input file name.
* \param output   The generic message-digest checksum result.
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_MD_FILE_IO_ERROR on an I/O error accessing
*                 the file pointed by \p path.
* \return         #MBEDTLS_ERR_MD_BAD_INPUT_DATA if \p md_info was NULL.
*/
mbedtls_md_file :: (md_info: *mbedtls_md_info_t, path: *u8, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function sets the HMAC key and prepares to
*                  authenticate a new message.
*
*                  Call this function after mbedtls_md_setup(), to use
*                  the MD context for an HMAC calculation, then call
*                  mbedtls_md_hmac_update() to provide the input data, and
*                  mbedtls_md_hmac_finish() to get the HMAC value.
*
* \param ctx       The message digest context containing an embedded HMAC
*                  context.
* \param key       The HMAC secret key.
* \param keylen    The length of the HMAC key in Bytes.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
*/
mbedtls_md_hmac_starts :: (ctx: *mbedtls_md_context_t, key: *u8, keylen: u64) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function feeds an input buffer into an ongoing HMAC
*                  computation.
*
*                  Call mbedtls_md_hmac_starts() or mbedtls_md_hmac_reset()
*                  before calling this function.
*                  You may call this function multiple times to pass the
*                  input piecewise.
*                  Afterwards, call mbedtls_md_hmac_finish().
*
* \param ctx       The message digest context containing an embedded HMAC
*                  context.
* \param input     The buffer holding the input data.
* \param ilen      The length of the input data.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
*/
mbedtls_md_hmac_update :: (ctx: *mbedtls_md_context_t, input: *u8, ilen: u64) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function finishes the HMAC operation, and writes
*                  the result to the output buffer.
*
*                  Call this function after mbedtls_md_hmac_starts() and
*                  mbedtls_md_hmac_update() to get the HMAC value. Afterwards
*                  you may either call mbedtls_md_free() to clear the context,
*                  or call mbedtls_md_hmac_reset() to reuse the context with
*                  the same HMAC key.
*
* \param ctx       The message digest context containing an embedded HMAC
*                  context.
* \param output    The generic HMAC checksum result.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
*/
mbedtls_md_hmac_finish :: (ctx: *mbedtls_md_context_t, output: *u8) -> s32 #foreign libmbedcrypto;

/**
* \brief           This function prepares to authenticate a new message with
*                  the same key as the previous HMAC operation.
*
*                  You may call this function after mbedtls_md_hmac_finish().
*                  Afterwards call mbedtls_md_hmac_update() to pass the new
*                  input.
*
* \param ctx       The message digest context containing an embedded HMAC
*                  context.
*
* \return          \c 0 on success.
* \return          #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                  failure.
*/
mbedtls_md_hmac_reset :: (ctx: *mbedtls_md_context_t) -> s32 #foreign libmbedcrypto;

/**
* \brief          This function calculates the full generic HMAC
*                 on the input buffer with the provided key.
*
*                 The function allocates the context, performs the
*                 calculation, and frees the context.
*
*                 The HMAC result is calculated as
*                 output = generic HMAC(hmac key, input buffer).
*
* \param md_info  The information structure of the message-digest algorithm
*                 to use.
* \param key      The HMAC secret key.
* \param keylen   The length of the HMAC secret key in Bytes.
* \param input    The buffer holding the input data.
* \param ilen     The length of the input data.
* \param output   The generic HMAC result.
*
* \return         \c 0 on success.
* \return         #MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter-verification
*                 failure.
*/
mbedtls_md_hmac :: (md_info: *mbedtls_md_info_t, key: *u8, keylen: u64, input: *u8, ilen: u64, output: *u8) -> s32 #foreign libmbedcrypto;

/** Constant-time buffer comparison without branches.
*
* This is equivalent to the standard memcmp function, but is likely to be
* compiled to code using bitwise operation rather than a branch.
*
* This function can be used to write constant-time code by replacing branches
* with bit operations using masks.
*
* \param a     Pointer to the first buffer.
* \param b     Pointer to the second buffer.
* \param n     The number of bytes to compare in the buffer.
*
* \return      Zero if the content of the two buffer is the same,
*              otherwise non-zero.
*/
mbedtls_ct_memcmp :: (a: *void, b: *void, n: u64) -> s32 #foreign libmbedcrypto;

#scope_file

#import "Basic"; // For assert


#run {
    {
        instance: mbedtls_aes_context;
        assert(((cast(*void)(*instance.private_nr)) - cast(*void)(*instance)) == 0, "mbedtls_aes_context.private_nr has unexpected offset % instead of 0", ((cast(*void)(*instance.private_nr)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_aes_context.private_nr)) == 4, "mbedtls_aes_context.private_nr has unexpected size % instead of 4", size_of(type_of(mbedtls_aes_context.private_nr)));
        assert(((cast(*void)(*instance.private_rk_offset)) - cast(*void)(*instance)) == 8, "mbedtls_aes_context.private_rk_offset has unexpected offset % instead of 8", ((cast(*void)(*instance.private_rk_offset)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_aes_context.private_rk_offset)) == 8, "mbedtls_aes_context.private_rk_offset has unexpected size % instead of 8", size_of(type_of(mbedtls_aes_context.private_rk_offset)));
        assert(((cast(*void)(*instance.private_buf)) - cast(*void)(*instance)) == 16, "mbedtls_aes_context.private_buf has unexpected offset % instead of 16", ((cast(*void)(*instance.private_buf)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_aes_context.private_buf)) == 272, "mbedtls_aes_context.private_buf has unexpected size % instead of 272", size_of(type_of(mbedtls_aes_context.private_buf)));
        assert(size_of(mbedtls_aes_context) == 288, "mbedtls_aes_context has size % instead of 288", size_of(mbedtls_aes_context));
    }

    {
        instance: mbedtls_aes_xts_context;
        assert(((cast(*void)(*instance.private_crypt)) - cast(*void)(*instance)) == 0, "mbedtls_aes_xts_context.private_crypt has unexpected offset % instead of 0", ((cast(*void)(*instance.private_crypt)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_aes_xts_context.private_crypt)) == 288, "mbedtls_aes_xts_context.private_crypt has unexpected size % instead of 288", size_of(type_of(mbedtls_aes_xts_context.private_crypt)));
        assert(((cast(*void)(*instance.private_tweak)) - cast(*void)(*instance)) == 288, "mbedtls_aes_xts_context.private_tweak has unexpected offset % instead of 288", ((cast(*void)(*instance.private_tweak)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_aes_xts_context.private_tweak)) == 288, "mbedtls_aes_xts_context.private_tweak has unexpected size % instead of 288", size_of(type_of(mbedtls_aes_xts_context.private_tweak)));
        assert(size_of(mbedtls_aes_xts_context) == 576, "mbedtls_aes_xts_context has size % instead of 576", size_of(mbedtls_aes_xts_context));
    }

    {
        instance: mbedtls_md_context_t;
        assert(((cast(*void)(*instance.private_md_info)) - cast(*void)(*instance)) == 0, "mbedtls_md_context_t.private_md_info has unexpected offset % instead of 0", ((cast(*void)(*instance.private_md_info)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_md_context_t.private_md_info)) == 8, "mbedtls_md_context_t.private_md_info has unexpected size % instead of 8", size_of(type_of(mbedtls_md_context_t.private_md_info)));
        assert(((cast(*void)(*instance.private_md_ctx)) - cast(*void)(*instance)) == 8, "mbedtls_md_context_t.private_md_ctx has unexpected offset % instead of 8", ((cast(*void)(*instance.private_md_ctx)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_md_context_t.private_md_ctx)) == 8, "mbedtls_md_context_t.private_md_ctx has unexpected size % instead of 8", size_of(type_of(mbedtls_md_context_t.private_md_ctx)));
        assert(((cast(*void)(*instance.private_hmac_ctx)) - cast(*void)(*instance)) == 16, "mbedtls_md_context_t.private_hmac_ctx has unexpected offset % instead of 16", ((cast(*void)(*instance.private_hmac_ctx)) - cast(*void)(*instance)));
        assert(size_of(type_of(mbedtls_md_context_t.private_hmac_ctx)) == 8, "mbedtls_md_context_t.private_hmac_ctx has unexpected size % instead of 8", size_of(type_of(mbedtls_md_context_t.private_hmac_ctx)));
        assert(size_of(mbedtls_md_context_t) == 24, "mbedtls_md_context_t has size % instead of 24", size_of(mbedtls_md_context_t));
    }
}


#if OS == .MACOS {
    libmbedcrypto :: #library,no_dll "macos/lib/libmbedcrypto";
    libmbedx509   :: #library,no_dll "macos/lib/libmbedx509";
    libmbedtls    :: #library,no_dll "macos/lib/libmbedtls";
} else #if OS == .LINUX {
    libmbedcrypto :: #library,no_dll "linux/lib/libmbedcrypto";
    libmbedx509   :: #library,no_dll "linux/lib/libmbedx509";
    libmbedtls    :: #library,no_dll "linux/lib/libmbedtls";
}

