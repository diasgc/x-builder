#!/bin/bash

lib='libressl'
pkg='libssl'
apt="${pkg}-dev"
dsc='Secure Sockets Layer and cryptography libraries'
lic='GPL'
src='https://github.com/libressl-portable/portable.git'
cfg='cmake'
eta='120'

cmake_bin="LIBRESSL_APPS"
cmake_config="-DLIBRESSL_TESTS=OFF -DENABLE_NC=ON -DENABLE_EXTRATESTS=OFF"

dev_bra='master'
dev_vrs=''
stb_bra=''
stb_vrs=''

lst_inc='tls.h openssl/*.h'
lst_lib='libcrypto libtls libssl'
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc='libssl.pc libtls.pc libcrypto.pc openssl.pc'

. xbuilder.sh

source_patch(){
  doAutogen ${dir_src} # do not remove
}

start

# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# Filelist
# --------
# include/tls.h
# include/openssl/lhash.h
# include/openssl/err.h
# include/openssl/opensslfeatures.h
# include/openssl/bio.h
# include/openssl/conf_api.h
# include/openssl/sha.h
# include/openssl/modes.h
# include/openssl/ecdsa.h
# include/openssl/pkcs12.h
# include/openssl/safestack.h
# include/openssl/opensslv.h
# include/openssl/crypto.h
# include/openssl/poly1305.h
# include/openssl/tls1.h
# include/openssl/ec.h
# include/openssl/objects.h
# include/openssl/ui.h
# include/openssl/txt_db.h
# include/openssl/idea.h
# include/openssl/hmac.h
# include/openssl/dso.h
# include/openssl/ssl3.h
# include/openssl/curve25519.h
# include/openssl/buffer.h
# include/openssl/opensslconf.h
# include/openssl/x509.h
# include/openssl/dtls1.h
# include/openssl/rc2.h
# include/openssl/ripemd.h
# include/openssl/blowfish.h
# include/openssl/pkcs7.h
# include/openssl/gost.h
# include/openssl/x509_verify.h
# include/openssl/aes.h
# include/openssl/md5.h
# include/openssl/rand.h
# include/openssl/asn1.h
# include/openssl/ssl23.h
# include/openssl/pem2.h
# include/openssl/srtp.h
# include/openssl/comp.h
# include/openssl/sm4.h
# include/openssl/cms.h
# include/openssl/dsa.h
# include/openssl/md4.h
# include/openssl/pem.h
# include/openssl/dh.h
# include/openssl/evp.h
# include/openssl/ui_compat.h
# include/openssl/cast.h
# include/openssl/rc4.h
# include/openssl/cmac.h
# include/openssl/ossl_typ.h
# include/openssl/whrlpool.h
# include/openssl/bn.h
# include/openssl/x509_vfy.h
# include/openssl/ocsp.h
# include/openssl/sm3.h
# include/openssl/des.h
# include/openssl/hkdf.h
# include/openssl/ecdh.h
# include/openssl/asn1t.h
# include/openssl/ssl.h
# include/openssl/stack.h
# include/openssl/ssl2.h
# include/openssl/obj_mac.h
# include/openssl/chacha.h
# include/openssl/rsa.h
# include/openssl/engine.h
# include/openssl/conf.h
# include/openssl/x509v3.h
# include/openssl/ts.h
# include/openssl/camellia.h
# etc/ssl/x509v3.cnf
# etc/ssl/openssl.cnf
# etc/ssl/cert.pem
# lib/pkgconfig/libssl.pc
# lib/pkgconfig/libtls.pc
# lib/pkgconfig/libcrypto.pc
# lib/pkgconfig/openssl.pc
# lib/libcrypto.a
# lib/libtls.a
# lib/libssl.a
# share/man/man5/x509v3.cnf.5
# share/man/man5/openssl.cnf.5
# share/man/man3/tls_init.3
# share/man/man3/BIO_should_retry.3
# share/man/man3/d2i_ASN1_OBJECT.3
# share/man/man3/X509_STORE_CTX_set_flags.3
# share/man/man3/i2d_CMS_bio_stream.3
# share/man/man3/EVP_PKEY_meth_get0_info.3
# share/man/man3/SSL_get_finished.3
# share/man/man3/TS_REQ_new.3
# share/man/man3/PROXY_POLICY_new.3
# share/man/man3/EXTENDED_KEY_USAGE_new.3
# share/man/man3/SSL_CTX_set_tmp_rsa_callback.3
# share/man/man3/PKCS7_sign_add_signer.3
# share/man/man3/BIO_new.3
# share/man/man3/EVP_rc4.3
# share/man/man3/OCSP_CRLID_new.3
# share/man/man3/BIO_get_data.3
# share/man/man3/d2i_X509_EXTENSION.3
# share/man/man3/BN_mod_mul_reciprocal.3
# share/man/man3/SSL_get_current_cipher.3
# share/man/man3/evp.3
# share/man/man3/DSA_sign.3
# share/man/man3/SSL_get_default_timeout.3
# share/man/man3/DSA_dup_DH.3
# share/man/man3/d2i_X509_ATTRIBUTE.3
# share/man/man3/OBJ_nid2obj.3
# share/man/man3/PKCS12_parse.3
# share/man/man3/ENGINE_unregister_RSA.3
# share/man/man3/OCSP_request_add1_nonce.3
# share/man/man3/DH_new.3
# share/man/man3/SSL_SESSION_get_time.3
# share/man/man3/DES_set_key.3
# share/man/man3/X509_ALGOR_dup.3
# share/man/man3/SSL_export_keying_material.3
# share/man/man3/CMS_get0_RecipientInfos.3
# share/man/man3/CMS_get0_SignerInfos.3
# share/man/man3/BIO_f_md.3
# share/man/man3/OCSP_resp_find_status.3
# share/man/man3/SSL_SESSION_new.3
# share/man/man3/OPENSSL_init_crypto.3
# share/man/man3/SSL_CTX_sess_set_get_cb.3
# share/man/man3/PKCS7_get_signer_info.3
# share/man/man3/SSL_get_SSL_CTX.3
# share/man/man3/SSL_COMP_add_compression_method.3
# share/man/man3/RSA_padding_add_PKCS1_type_1.3
# share/man/man3/BN_mod_mul_montgomery.3
# share/man/man3/ASN1_generate_nconf.3
# share/man/man3/OPENSSL_malloc.3
# share/man/man3/X509v3_get_ext_by_NID.3
# share/man/man3/SSL_get_server_tmp_key.3
# share/man/man3/SSL_get_error.3
# share/man/man3/CMS_final.3
# share/man/man3/X509_STORE_CTX_get_ex_new_index.3
# share/man/man3/SSL_alert_type_string.3
# share/man/man3/X509_PUBKEY_new.3
# share/man/man3/SSL_num_renegotiations.3
# share/man/man3/SSL_set1_host.3
# share/man/man3/X509_STORE_CTX_new.3
# share/man/man3/ERR.3
# share/man/man3/SSL_state_string.3
# share/man/man3/X25519.3
# share/man/man3/SSL_load_client_CA_file.3
# share/man/man3/crypto.3
# share/man/man3/DH_size.3
# share/man/man3/PKCS8_PRIV_KEY_INFO_new.3
# share/man/man3/EVP_DigestSignInit.3
# share/man/man3/EVP_sm3.3
# share/man/man3/EVP_PKEY_encrypt.3
# share/man/man3/X509_STORE_CTX_set_verify_cb.3
# share/man/man3/X509_OBJECT_get0_X509.3
# share/man/man3/EVP_PKEY_meth_new.3
# share/man/man3/BIO_get_ex_new_index.3
# share/man/man3/ERR_print_errors.3
# share/man/man3/BIO_f_base64.3
# share/man/man3/X509_find_by_subject.3
# share/man/man3/d2i_PROXY_POLICY.3
# share/man/man3/SSL_SESSION_get_protocol_version.3
# share/man/man3/RSA_private_encrypt.3
# share/man/man3/SSL_CTX_set_client_cert_cb.3
# share/man/man3/RSA_generate_key.3
# share/man/man3/ASN1_time_parse.3
# share/man/man3/SSL_write.3
# share/man/man3/BIO_set_callback.3
# share/man/man3/EVP_SealInit.3
# share/man/man3/PEM_X509_INFO_read.3
# share/man/man3/UI_new.3
# share/man/man3/BN_cmp.3
# share/man/man3/d2i_DHparams.3
# share/man/man3/RSA_meth_new.3
# share/man/man3/SSL_CTX_free.3
# share/man/man3/X509_get_pubkey.3
# share/man/man3/X509_CRL_print.3
# share/man/man3/SSL_CTX_ctrl.3
# share/man/man3/SSL_dup.3
# share/man/man3/X509_cmp.3
# share/man/man3/ChaCha.3
# share/man/man3/ENGINE_set_flags.3
# share/man/man3/BN_CTX_start.3
# share/man/man3/X509_ocspid_print.3
# share/man/man3/SSL_get_client_random.3
# share/man/man3/SSL_CTX_set_tlsext_status_cb.3
# share/man/man3/d2i_GENERAL_NAME.3
# share/man/man3/OCSP_cert_to_id.3
# share/man/man3/X509_check_ca.3
# share/man/man3/SSL_dup_CA_list.3
# share/man/man3/X509_CINF_new.3
# share/man/man3/d2i_X509_SIG.3
# share/man/man3/ERR_set_mark.3
# share/man/man3/X509_NAME_get_index_by_NID.3
# share/man/man3/EVP_camellia_128_cbc.3
# share/man/man3/d2i_ASN1_SEQUENCE_ANY.3
# share/man/man3/CMS_add0_cert.3
# share/man/man3/SSL_SESSION_is_resumable.3
# share/man/man3/X509_CRL_get0_by_serial.3
# share/man/man3/X509_EXTENSION_set_object.3
# share/man/man3/SSL_CTX_set1_groups.3
# share/man/man3/SSL_get_rbio.3
# share/man/man3/SSL_get_ciphers.3
# share/man/man3/UI_get_string_type.3
# share/man/man3/SSL_session_reused.3
# share/man/man3/EVP_DigestInit.3
# share/man/man3/SSL_copy_session_id.3
# share/man/man3/d2i_AUTHORITY_KEYID.3
# share/man/man3/CMS_add1_recipient_cert.3
# share/man/man3/ERR_GET_LIB.3
# share/man/man3/PKCS7_decrypt.3
# share/man/man3/SSL_CTX_sess_set_cache_size.3
# share/man/man3/SSL_CTX_set_tmp_dh_callback.3
# share/man/man3/PEM_read_SSL_SESSION.3
# share/man/man3/ENGINE_register_all_RSA.3
# share/man/man3/X509_REQ_new.3
# share/man/man3/MD5.3
# share/man/man3/SSL_CTX_sess_number.3
# share/man/man3/EVP_AEAD_CTX_init.3
# share/man/man3/RSA_get0_key.3
# share/man/man3/BN_new.3
# share/man/man3/SSL_CTX_set_read_ahead.3
# share/man/man3/PKCS12_create.3
# share/man/man3/ASN1_item_d2i.3
# share/man/man3/BIO_read.3
# share/man/man3/PKCS7_set_type.3
# share/man/man3/SSL_CTX_set_default_passwd_cb.3
# share/man/man3/X509_sign.3
# share/man/man3/tls_config_set_protocols.3
# share/man/man3/SSL_SESSION_print.3
# share/man/man3/EVP_PKEY_CTX_new.3
# share/man/man3/X509_keyid_set1.3
# share/man/man3/BIO_f_buffer.3
# share/man/man3/PEM_write_bio_CMS_stream.3
# share/man/man3/SSL_clear.3
# share/man/man3/SMIME_read_PKCS7.3
# share/man/man3/SSL_get_certificate.3
# share/man/man3/EVP_PKEY_verify_recover.3
# share/man/man3/PKCS7_final.3
# share/man/man3/PEM_bytes_read_bio.3
# share/man/man3/BIO_s_file.3
# share/man/man3/DSA_SIG_new.3
# share/man/man3/DSA_generate_parameters.3
# share/man/man3/PEM_write_bio_PKCS7_stream.3
# share/man/man3/X509_STORE_get_by_subject.3
# share/man/man3/SSL_get_peer_certificate.3
# share/man/man3/X509_get_version.3
# share/man/man3/d2i_ASN1_OCTET_STRING.3
# share/man/man3/EC_POINT_add.3
# share/man/man3/SHA1.3
# share/man/man3/PKCS7_set_content.3
# share/man/man3/SSL_CTX_set_tlsext_use_srtp.3
# share/man/man3/X509_add1_trust_object.3
# share/man/man3/SSL_pending.3
# share/man/man3/des_read_pw.3
# share/man/man3/SSL_CTX_set_msg_callback.3
# share/man/man3/PKCS7_verify.3
# share/man/man3/CMS_sign.3
# share/man/man3/RSA_set_method.3
# share/man/man3/bn_dump.3
# share/man/man3/X509V3_EXT_print.3
# share/man/man3/d2i_PKCS8_PRIV_KEY_INFO.3
# share/man/man3/SSL_CTX_set_quiet_shutdown.3
# share/man/man3/EVP_PKEY_sign.3
# share/man/man3/lh_new.3
# share/man/man3/CMS_verify_receipt.3
# share/man/man3/X509_policy_check.3
# share/man/man3/ENGINE_new.3
# share/man/man3/DSA_get_ex_new_index.3
# share/man/man3/ASN1_TYPE_get.3
# share/man/man3/SSL_get_verify_result.3
# share/man/man3/tls_config_ocsp_require_stapling.3
# share/man/man3/SSL_get_peer_cert_chain.3
# share/man/man3/SSL_SESSION_get_compress_id.3
# share/man/man3/SSL_CTX_set_tlsext_servername_callback.3
# share/man/man3/X509_STORE_new.3
# share/man/man3/ASN1_STRING_length.3
# share/man/man3/PKCS7_dataInit.3
# share/man/man3/x509_verify.3
# share/man/man3/OPENSSL_sk_new.3
# share/man/man3/X509_STORE_set1_param.3
# share/man/man3/SSL_set_bio.3
# share/man/man3/X509_ATTRIBUTE_new.3
# share/man/man3/d2i_X509_REQ.3
# share/man/man3/RAND_bytes.3
# share/man/man3/d2i_OCSP_RESPONSE.3
# share/man/man3/SSL_want.3
# share/man/man3/EVP_EncryptInit.3
# share/man/man3/ECDH_compute_key.3
# share/man/man3/X509_STORE_set_verify_cb_func.3
# share/man/man3/STACK_OF.3
# share/man/man3/BIO_s_connect.3
# share/man/man3/SSL_CTX_set_timeout.3
# share/man/man3/RSA_PSS_PARAMS_new.3
# share/man/man3/SSL_rstate_string.3
# share/man/man3/NAME_CONSTRAINTS_new.3
# share/man/man3/d2i_SSL_SESSION.3
# share/man/man3/ERR_put_error.3
# share/man/man3/BIO_s_bio.3
# share/man/man3/d2i_DIST_POINT.3
# share/man/man3/X509_check_issued.3
# share/man/man3/ERR_error_string.3
# share/man/man3/BN_set_negative.3
# share/man/man3/UI_create_method.3
# share/man/man3/d2i_OCSP_REQUEST.3
# share/man/man3/RSA_get_ex_new_index.3
# share/man/man3/X509V3_extensions_print.3
# share/man/man3/HMAC.3
# share/man/man3/X509_TRUST_set.3
# share/man/man3/RIPEMD160.3
# share/man/man3/EVP_VerifyInit.3
# share/man/man3/CMS_ContentInfo_new.3
# share/man/man3/EC_GFp_simple_method.3
# share/man/man3/d2i_POLICYINFO.3
# share/man/man3/SSL_CTX_set_info_callback.3
# share/man/man3/RSA_blinding_on.3
# share/man/man3/BIO_s_mem.3
# share/man/man3/RSA_pkey_ctx_ctrl.3
# share/man/man3/CMS_get1_ReceiptRequest.3
# share/man/man3/CMS_sign_receipt.3
# share/man/man3/tls_config_set_session_id.3
# share/man/man3/CMS_uncompress.3
# share/man/man3/SSL_get_ex_new_index.3
# share/man/man3/SSL_set_psk_use_session_callback.3
# share/man/man3/X509_LOOKUP_new.3
# share/man/man3/X509_NAME_add_entry_by_txt.3
# share/man/man3/RSA_sign_ASN1_OCTET_STRING.3
# share/man/man3/X509_STORE_load_locations.3
# share/man/man3/RAND_set_rand_method.3
# share/man/man3/SSL_CTX_set_ssl_version.3
# share/man/man3/ERR_asprintf_error_data.3
# share/man/man3/SSL_CTX_set_session_id_context.3
# share/man/man3/SSL_CTX_get0_certificate.3
# share/man/man3/d2i_X509_CRL.3
# share/man/man3/BN_bn2bin.3
# share/man/man3/EVP_PKEY_set1_RSA.3
# share/man/man3/SSL_read_early_data.3
# share/man/man3/RSA_new.3
# share/man/man3/ASN1_INTEGER_get.3
# share/man/man3/d2i_TS_REQ.3
# share/man/man3/CMS_add1_signer.3
# share/man/man3/BN_copy.3
# share/man/man3/GENERAL_NAME_new.3
# share/man/man3/SSL_CTX_add_session.3
# share/man/man3/OCSP_REQUEST_new.3
# share/man/man3/SSL_CTX_set_alpn_select_cb.3
# share/man/man3/CMS_decrypt.3
# share/man/man3/PKCS12_new.3
# share/man/man3/SSL_get_shared_ciphers.3
# share/man/man3/X509_LOOKUP_hash_dir.3
# share/man/man3/ENGINE_get_default_RSA.3
# share/man/man3/BIO_ctrl.3
# share/man/man3/CRYPTO_get_mem_functions.3
# share/man/man3/PKCS7_sign.3
# share/man/man3/d2i_X509.3
# share/man/man3/DSA_do_sign.3
# share/man/man3/BUF_MEM_new.3
# share/man/man3/SSL_set_max_send_fragment.3
# share/man/man3/X509_NAME_print_ex.3
# share/man/man3/OPENSSL_cleanse.3
# share/man/man3/tls_load_file.3
# share/man/man3/ERR_load_crypto_strings.3
# share/man/man3/X509_digest.3
# share/man/man3/SMIME_write_PKCS7.3
# share/man/man3/tls_conn_version.3
# share/man/man3/SSL_CTX_set_verify.3
# share/man/man3/DSA_get0_pqg.3
# share/man/man3/d2i_CMS_ContentInfo.3
# share/man/man3/PKCS7_add_attribute.3
# share/man/man3/OpenSSL_add_all_algorithms.3
# share/man/man3/SSL_renegotiate.3
# share/man/man3/BF_set_key.3
# share/man/man3/BIO_printf.3
# share/man/man3/SSL_set_SSL_CTX.3
# share/man/man3/X509_SIG_new.3
# share/man/man3/X509_check_host.3
# share/man/man3/BIO_s_accept.3
# share/man/man3/OPENSSL_load_builtin_modules.3
# share/man/man3/BN_set_flags.3
# share/man/man3/POLICYINFO_new.3
# share/man/man3/X509_PURPOSE_set.3
# share/man/man3/X509_check_private_key.3
# share/man/man3/i2d_PKCS7_bio_stream.3
# share/man/man3/OPENSSL_config.3
# share/man/man3/EVP_aes_128_cbc.3
# share/man/man3/DH_get0_pqg.3
# share/man/man3/SSL_CTX_set_min_proto_version.3
# share/man/man3/BASIC_CONSTRAINTS_new.3
# share/man/man3/DSA_generate_key.3
# share/man/man3/ASN1_item_new.3
# share/man/man3/EVP_PKEY_asn1_new.3
# share/man/man3/BIO_f_ssl.3
# share/man/man3/SSL_get_client_CA_list.3
# share/man/man3/SSL_CTX_load_verify_locations.3
# share/man/man3/CRYPTO_lock.3
# share/man/man3/SSL_CTX_set_generate_session_id.3
# share/man/man3/BN_BLINDING_new.3
# share/man/man3/PKCS12_newpass.3
# share/man/man3/PKCS5_PBKDF2_HMAC.3
# share/man/man3/SSL_CTX_set_cert_verify_callback.3
# share/man/man3/X509_check_purpose.3
# share/man/man3/RSA_sign.3
# share/man/man3/ENGINE_register_RSA.3
# share/man/man3/ACCESS_DESCRIPTION_new.3
# share/man/man3/SSL_CTX_get_verify_mode.3
# share/man/man3/d2i_BASIC_CONSTRAINTS.3
# share/man/man3/X509_get_subject_name.3
# share/man/man3/d2i_X509_ALGOR.3
# share/man/man3/EVP_PKEY_get_default_digest_nid.3
# share/man/man3/EVP_OpenInit.3
# share/man/man3/RSA_public_encrypt.3
# share/man/man3/DSA_set_method.3
# share/man/man3/EVP_PKEY_keygen.3
# share/man/man3/EVP_PKEY_CTX_ctrl.3
# share/man/man3/BN_set_bit.3
# share/man/man3/SSL_CTX_add_extra_chain_cert.3
# share/man/man3/X509_NAME_new.3
# share/man/man3/SSL_shutdown.3
# share/man/man3/CONF_modules_free.3
# share/man/man3/SSL_CTX_set_max_cert_list.3
# share/man/man3/DTLSv1_listen.3
# share/man/man3/X509_print_ex.3
# share/man/man3/SSL_set1_param.3
# share/man/man3/SSL_set_shutdown.3
# share/man/man3/d2i_ECPKParameters.3
# share/man/man3/ERR_get_error.3
# share/man/man3/BIO_s_socket.3
# share/man/man3/X509V3_get_d2i.3
# share/man/man3/BIO_s_null.3
# share/man/man3/CRYPTO_memcmp.3
# share/man/man3/SSL_connect.3
# share/man/man3/SSL_SESSION_get_ex_new_index.3
# share/man/man3/tls_accept_socket.3
# share/man/man3/d2i_PKCS8PrivateKey_bio.3
# share/man/man3/UI_UTIL_read_pw.3
# share/man/man3/PEM_ASN1_read.3
# share/man/man3/X509_cmp_time.3
# share/man/man3/ASN1_STRING_print_ex.3
# share/man/man3/tls_client.3
# share/man/man3/EVP_PKEY_derive.3
# share/man/man3/DSA_meth_new.3
# share/man/man3/ENGINE_set_default.3
# share/man/man3/DH_get_ex_new_index.3
# share/man/man3/ECDSA_SIG_new.3
# share/man/man3/EVP_sm4_cbc.3
# share/man/man3/get_rfc3526_prime_8192.3
# share/man/man3/d2i_X509_NAME.3
# share/man/man3/BN_zero.3
# share/man/man3/EC_KEY_METHOD_new.3
# share/man/man3/X509_new.3
# share/man/man3/SSL_CTX_set_cipher_list.3
# share/man/man3/ERR_remove_state.3
# share/man/man3/ssl.3
# share/man/man3/OCSP_sendreq_new.3
# share/man/man3/SSL_CTX_set_client_CA_list.3
# share/man/man3/ASN1_OBJECT_new.3
# share/man/man3/PKCS7_new.3
# share/man/man3/SSL_CTX_set_cert_store.3
# share/man/man3/SSL_set_session.3
# share/man/man3/CMS_verify.3
# share/man/man3/EVP_EncodeInit.3
# share/man/man3/SSL_CTX_set_tlsext_ticket_key_cb.3
# share/man/man3/SSL_get_ex_data_X509_STORE_CTX_idx.3
# share/man/man3/CMS_encrypt.3
# share/man/man3/SSL_get_version.3
# share/man/man3/BN_generate_prime.3
# share/man/man3/d2i_PKCS7.3
# share/man/man3/d2i_DSAPublicKey.3
# share/man/man3/SSL_CIPHER_get_name.3
# share/man/man3/SSL_CTX_set_options.3
# share/man/man3/RC4.3
# share/man/man3/tls_read.3
# share/man/man3/BN_get0_nist_prime_521.3
# share/man/man3/tls_config_verify.3
# share/man/man3/BN_add.3
# share/man/man3/DSA_size.3
# share/man/man3/X509_get1_email.3
# share/man/man3/X509_check_trust.3
# share/man/man3/AES_encrypt.3
# share/man/man3/X509_INFO_new.3
# share/man/man3/BN_mod_inverse.3
# share/man/man3/SMIME_write_CMS.3
# share/man/man3/EVP_PKEY_verify.3
# share/man/man3/SSL_get_session.3
# share/man/man3/SSL_library_init.3
# share/man/man3/X509_VERIFY_PARAM_set_flags.3
# share/man/man3/ASN1_STRING_new.3
# share/man/man3/SSL_CTX_new.3
# share/man/man3/SSL_SESSION_get0_cipher.3
# share/man/man3/tls_connect.3
# share/man/man3/AUTHORITY_KEYID_new.3
# share/man/man3/BN_num_bytes.3
# share/man/man3/EVP_DigestVerifyInit.3
# share/man/man3/BIO_f_cipher.3
# share/man/man3/d2i_ASN1_NULL.3
# share/man/man3/RAND_add.3
# share/man/man3/PKCS12_SAFEBAG_new.3
# share/man/man3/RAND_load_file.3
# share/man/man3/PKCS7_encrypt.3
# share/man/man3/X509_NAME_ENTRY_get_object.3
# share/man/man3/ASN1_get_object.3
# share/man/man3/d2i_PrivateKey.3
# share/man/man3/X509_get0_signature.3
# share/man/man3/SSL_SESSION_get_id.3
# share/man/man3/SSL_new.3
# share/man/man3/SSL_SESSION_set1_id_context.3
# share/man/man3/DH_set_method.3
# share/man/man3/ESS_SIGNING_CERT_new.3
# share/man/man3/ERR_clear_error.3
# share/man/man3/d2i_PKEY_USAGE_PERIOD.3
# share/man/man3/BIO_dump.3
# share/man/man3/CONF_modules_load_file.3
# share/man/man3/SSL_CTX_flush_sessions.3
# share/man/man3/SSL_read.3
# share/man/man3/EVP_des_cbc.3
# share/man/man3/ENGINE_init.3
# share/man/man3/PKCS7_dataFinal.3
# share/man/man3/X509_STORE_CTX_get_error.3
# share/man/man3/EVP_PKEY_print_private.3
# share/man/man3/BIO_new_CMS.3
# share/man/man3/EVP_PKEY_cmp.3
# share/man/man3/X509_signature_dump.3
# share/man/man3/ASN1_put_object.3
# share/man/man3/SSL_set_connect_state.3
# share/man/man3/SSL_accept.3
# share/man/man3/SSL_SESSION_has_ticket.3
# share/man/man3/CMAC_Init.3
# share/man/man3/BN_add_word.3
# share/man/man3/ENGINE_ctrl.3
# share/man/man3/EVP_PKEY_new.3
# share/man/man3/d2i_ESS_SIGNING_CERT.3
# share/man/man3/X509_policy_tree_level_count.3
# share/man/man3/EC_POINT_new.3
# share/man/man3/X509_get0_notBefore.3
# share/man/man3/DIST_POINT_new.3
# share/man/man3/SSL_CTX_use_certificate.3
# share/man/man3/OPENSSL_VERSION_NUMBER.3
# share/man/man3/X509_verify_cert.3
# share/man/man3/SSL_set_fd.3
# share/man/man3/X509_CRL_new.3
# share/man/man3/BN_rand.3
# share/man/man3/RSA_size.3
# share/man/man3/d2i_RSAPublicKey.3
# share/man/man3/BIO_meth_new.3
# share/man/man3/CMS_compress.3
# share/man/man3/OPENSSL_init_ssl.3
# share/man/man3/X509_get_serialNumber.3
# share/man/man3/OCSP_SERVICELOC_new.3
# share/man/man3/BIO_find_type.3
# share/man/man3/RSA_print.3
# share/man/man3/EVP_whirlpool.3
# share/man/man3/ASN1_TIME_set.3
# share/man/man3/d2i_PKCS12.3
# share/man/man3/SSL_CTX_set_session_cache_mode.3
# share/man/man3/DSA_new.3
# share/man/man3/tls_ocsp_process_response.3
# share/man/man3/EVP_PKEY_asn1_get_count.3
# share/man/man3/CMS_get0_type.3
# share/man/man3/ASN1_STRING_TABLE_add.3
# share/man/man3/BN_CTX_new.3
# share/man/man3/ASN1_parse_dump.3
# share/man/man3/X509_NAME_hash.3
# share/man/man3/SSL_SESSION_free.3
# share/man/man3/SSL_set_verify_result.3
# share/man/man3/SXNET_new.3
# share/man/man3/EC_KEY_new.3
# share/man/man3/SSL_do_handshake.3
# share/man/man3/EVP_SignInit.3
# share/man/man3/PEM_read_bio_PrivateKey.3
# share/man/man3/SSL_CTX_get_ex_new_index.3
# share/man/man3/EVP_PKEY_decrypt.3
# share/man/man3/ERR_load_strings.3
# share/man/man3/BIO_push.3
# share/man/man3/X509_REVOKED_new.3
# share/man/man3/PEM_read.3
# share/man/man3/DH_generate_parameters.3
# share/man/man3/SMIME_read_CMS.3
# share/man/man3/PKEY_USAGE_PERIOD_new.3
# share/man/man3/SSL_get_fd.3
# share/man/man3/SSL_free.3
# share/man/man3/SSL_set_tmp_ecdh.3
# share/man/man3/BIO_s_fd.3
# share/man/man3/DH_generate_key.3
# share/man/man3/CRYPTO_set_ex_data.3
# share/man/man3/lh_stats.3
# share/man/man3/BN_swap.3
# share/man/man3/EC_GROUP_copy.3
# share/man/man3/SSL_get_state.3
# share/man/man3/OCSP_response_status.3
# share/man/man3/BIO_f_null.3
# share/man/man3/ENGINE_add.3
# share/man/man3/SSL_CTX_add1_chain_cert.3
# share/man/man3/SSL_CTX_sessions.3
# share/man/man3/SSL_CTX_set_mode.3
# share/man/man3/EVP_BytesToKey.3
# share/man/man3/EC_GROUP_new.3
# share/man/man3/SSL_SESSION_get0_peer.3
# share/man/man3/RSA_check_key.3
# share/man/man3/ENGINE_set_RSA.3
