package happy.jaj.prj.com.db;
//////////////////
//테스트용 파일입니다./// 
//////////////////
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Attended_ConnectDB {
    private static Attended_ConnectDB instance = new Attended_ConnectDB();

    public static Attended_ConnectDB getInstance() {
        return instance;
    }
    public Attended_ConnectDB() {  }

    // oracle 계정
    String jdbcUrl = "jdbc:oracle:thin:@192.168.10.79:1521:xe";
    String user = "JAJ";
    String userPw = "pw";

    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;

    String sql = "";
    String sql2 = "";
    String returns = "a";

    public String connectionDB(String id, String pwd) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(jdbcUrl, user, userPw);

            sql = "SELECT id FROM userTBL WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                returns = "이미 존재하는 아이디 입니다.";
            } else {
                sql2 = "INSERT INTO userTBL VALUES(?,?)";
                pstmt2 = conn.prepareStatement(sql2);
                pstmt2.setString(1, id);
                pstmt2.setString(2, pwd);
                pstmt2.executeUpdate();
                returns = "회원 가입 성공 !";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt2 != null)try {pstmt2.close();    } catch (SQLException ex) {}
            if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
            if (conn != null)try {conn.close();    } catch (SQLException ex) {    }
        }
        return returns;
    }
}
