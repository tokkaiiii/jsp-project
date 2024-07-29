package member;

import static member.util.SignupConst.FAILURE;
import static member.util.SignupConst.SUCCESS;

import domain.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/member/member.do")
public class MemberController extends HttpServlet {

  public void service(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException {
    String method = req.getParameter("method");
    if (method != null) {
      if (!method.isBlank()) {
        switch (method) {
          case "login":
            login(req, res);
            break;

          case "match":
            match(req, res);
            break;

          case "joinForm":
            joinForm(req, res);
            break;

          case "join":
            join(req, res);
            break;

          case "emailCheck":
            emailCheck(req, res);
            break;

          case "findId":
            findId(req, res);break;

          case "findPwd": findPwd(req, res);break;

          case "myId":
            try {
              myId(req, res);
            } catch (Exception e) {
              System.out.println("오류");
              throw new RuntimeException(e);
            }
            break;
        }
      }
      req.getRequestDispatcher("/WEB-INF/jsp/main/main.jsp").forward(req, res);
    }
    req.getRequestDispatcher("/WEB-INF/jsp/main/main.jsp").forward(req, res);
  }

  //로그인
  private void login(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException {
    req.getRequestDispatcher("/WEB-INF/jsp/member/login.jsp").forward(req, res);
  }

  //로그인 인증
  private void match(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException {
    String email = req.getParameter("login-email");
    String password = req.getParameter("login-password");
    MemberService service = MemberService.getInstance();
    if (email != null && password != null) {
      int result = service.passwordMatch(email, password);
      if (result == SUCCESS) {
        Member member = service.getMember(email);
        HttpSession session = req.getSession();
        session.setAttribute("member", member);
      }
      System.out.println("[MemberController] match 메소드에서 result: " + result);
      req.setAttribute("result", result);
      req.getRequestDispatcher("/WEB-INF/jsp/main/main.jsp").forward(req, res);
    }
  }

  //회원가입 뷰로 가기
  private void joinForm(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException {
    req.getRequestDispatcher("/WEB-INF/jsp/member/join_form.jsp").forward(req, res);
  }

  //회원가입
  private void join(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException {
    String email = req.getParameter("email");
    String password = req.getParameter("password");
    String name = req.getParameter("name");
    String nickname = req.getParameter("nickname");
    MemberService service = MemberService.getInstance();
    if (email != null && password != null && name != null && nickname != null) {
      int result = service.join(email, password, name, nickname);
      if (result != FAILURE) {
        Member member = service.getMember(email);
        HttpSession session = req.getSession();
        session.setAttribute("member", member);
      }
      req.setAttribute("result", result);
      req.getRequestDispatcher("/WEB-INF/jsp/member/join_message.jsp").forward(req, res);
    }
  }
  private void emailCheck(HttpServletRequest req, HttpServletResponse res)
    throws IOException, ServletException {
    String email = req.getParameter("email");
    MemberService service = MemberService.getInstance();
    int valid = service.emailCheck(email);
    StringBuilder jsonBuilder = new StringBuilder("{\"valid\":").append(valid).append("}");

    res.setContentType("application/json;charset=UTF-8");
    res.setCharacterEncoding("UTF-8");
    PrintWriter out = res.getWriter();
    out.print(jsonBuilder);
    out.flush();
  }
  private void findId(HttpServletRequest req, HttpServletResponse res)
    throws IOException, ServletException {
    req.getRequestDispatcher("/WEB-INF/jsp/member/find_id.jsp").forward(req, res);
  }

  private void findPwd(HttpServletRequest req, HttpServletResponse res)
      throws IOException, ServletException {
    req.getRequestDispatcher("/WEB-INF/jsp/member/find_pwd.jsp").forward(req, res);
  }

  private void myId(HttpServletRequest req, HttpServletResponse res)
      throws Exception {
    String email = req.getParameter("email");
    String name = req.getParameter("name");
    Member member = null;
    if (email != null && name != null) {
      MemberService service = MemberService.getInstance();
      member = service.getMemberByEmail(email, name);
      MailService mailService = new MailService();
      String authenticationCode = mailService.sendEmail(member.getEmail());
      HttpSession session = req.getSession();
      session.setAttribute("member", member);
      session.setAttribute("authenticationCode", authenticationCode);
      req.getRequestDispatcher("/WEB-INF/jsp/member/my_id.jsp").forward(req, res);
    }
  }
}
