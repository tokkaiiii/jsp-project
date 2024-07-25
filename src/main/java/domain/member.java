package domain;

import java.sql.Date;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.ToString;

@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
public class member {

  private final int seq;
  private final String email;
  private final String password;
  private final String name;
  private final String nickname;
  private final Date rdate;
  private final int user_type;
  private final int valid;
}
