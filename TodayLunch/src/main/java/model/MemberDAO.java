package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class MemberDAO {

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement psmt = null;
	MemberDTO dto=null;

	int cnt = 0;

	public void DBconn() {

		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");

			String url = "jdbc:oracle:thin:@project-db-stu.ddns.net:1524:xe";
			String dbid = "campus_e_1_0115";
			String dbpw = "smhrd1";
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void DBclose() {

		try {

			if (rs != null) {
				rs.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}

		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	
	
	//�α��� ����
	public MemberDTO login(MemberDTO dto) {
		MemberDTO info = null;

		System.out.println(dto.getEmail());
		System.out.println(dto.getPw());

		try {
			DBconn();
			System.out.println("DB�����");

			String sql = "select*from test_member where email=? and pw=?";

			// SQL�� ����
			psmt = conn.prepareStatement(sql);
			// ?�� �� ä���
			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getPw());

			// ����
			rs = psmt.executeQuery();

			// rs.next(): Ŀ���� �������� ���� �ִ��� ������ Ȯ���ϴ� �޼ҵ�
			// ������ true ������ false
			if (rs.next()) {
				String email = rs.getString("email");
				String pw = rs.getString(2);
				String nickname = rs.getString(3);
				String dong = rs.getString(4);

				System.out.println(email + pw + nickname + dong);

				info = new MemberDTO(email, pw, nickname, dong);
				System.out.println(info.getEmail());

			}

		} catch (Exception e) {

		} finally {
			DBclose();
		}
		return info;
	}

	// ȸ������ �޼ҵ�
	public int join(MemberDTO dto) {

		try {
			DBconn();

			String sql = "insert into test_member values(?,?,?,?)";

			// sql-> DB�� ����
			psmt = conn.prepareStatement(sql);

			// ?�� �� �־��ֱ�

			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getPw());
			psmt.setString(3, dto.getNickname());
			psmt.setString(4, dto.getDong());

			// ����
			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBclose();

		}
		return cnt;

	}

	

}
