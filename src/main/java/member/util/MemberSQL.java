package member.util;

public class MemberSQL {

  public static final String PASSWORDMATCH = "select PASSWORD from MEMBER where EMAIL = ?";

  public static final String GETMEMBER = "select * from MEMBER where EMAIL = ?";

  public static final String JOIN = "insert into MEMBER(EMAIL,PASSWORD,NAME,NICKNAME,RDATE,USER_TYPE,VALID) values(?,?,?,?,now(),0,0)";

}
