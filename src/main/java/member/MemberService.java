package member;

import domain.Member;
import lombok.Getter;

public class MemberService {

  MemberDAO dao;
  @Getter
  private static MemberService instance = new MemberService();

  private MemberService() {
    dao = new MemberDAO();
  }

  public Member getMember(String email) {
    return dao.getMember(email);
  }

  public int passwordMatch(String email, String password) {
    return dao.passwordMatch(email, password);
  }

  public int join(String email, String password, String name,String nickname){
    return dao.join(email,password,name,nickname);
  }
 public int emailCheck(String email){
    return dao.emailCheck(email);
 }
}
