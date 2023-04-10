package com.web.ddentist.security;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class AesEncryptionUtil {
	
	private static final String ALGORITHM = "AES";
	private static final byte[] KEY = "projectTwoClick0".getBytes();
	
	
	public static String encrypt(String value) {
		
		try {
			SecretKeySpec keySpec = new SecretKeySpec(KEY, ALGORITHM);
			Cipher cipher = Cipher.getInstance(ALGORITHM);
			cipher.init(Cipher.ENCRYPT_MODE, keySpec);
			byte[] encrypted = cipher.doFinal(value.getBytes());
			
			return Base64.getEncoder().encodeToString(encrypted);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public static String decrypt(String encryptedValue) {
		
		try {
			SecretKeySpec keySpec = new SecretKeySpec(KEY, ALGORITHM);
			Cipher cipher = Cipher.getInstance(ALGORITHM);
			cipher.init(Cipher.DECRYPT_MODE, keySpec);
			byte[] decoded = Base64.getDecoder().decode(encryptedValue);
			byte[] decrypted = cipher.doFinal(decoded);
			
			return new String(decrypted);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
}
