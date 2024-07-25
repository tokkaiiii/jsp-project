package member;

import static member.util.memberSQL.LOGIN;

import domain.member;
import dbutil.BaseDAO;
import java.sql.SQLException;
import javax.sql.DataSource;
import java.sql.*;

class memberDAO extends BaseDAO {

  member getMember(String email) throws SQLException {
    Connection con = getConnection();
    PreparedStatement ps = con.prepareStatement(LOGIN);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    member member = null;
    if (rs.next()) {
      member.builder()
          .seq(rs.getInt("member_seq"))
          .email(rs.getString("email"))
          .password(rs.getString("password"))
          .name(rs.getString("name"))
    }
    return null;
  }
}
