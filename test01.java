import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class VulnerableApp {

    public static void main(String[] args) throws Exception {

        // 사용자 입력
        String username = args[0];

        Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/test",
                "root",
                "password"
        );

        Statement stmt = conn.createStatement();

        // 취약점: 사용자 입력을 SQL Query에 직접 결합
        String query =
                "SELECT * FROM users WHERE username = '" + username + "'";

        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
            System.out.println(rs.getString("username"));
        }

        rs.close();
        stmt.close();
        conn.close();
    }
}
