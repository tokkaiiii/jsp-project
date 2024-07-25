package member.util;

import org.mindrot.jbcrypt.BCrypt;

public abstract class BcryptEncoder {

  public static String encode(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  public static void isPasswordMatch(String password, String hashedPassword) {
    if (BCrypt.checkpw(password, hashedPassword)) {
      System.out.println("Password verified");
    } else {
      System.out.println("Password not verified");
    }
  }
}