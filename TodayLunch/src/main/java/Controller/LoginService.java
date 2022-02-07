package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MemberDAO;
import model.MemberDTO;

@WebServlet("/LoginService")
public class LoginService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("LoginService");
		request.setCharacterEncoding("UTF-8");

		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		
		System.out.println("email"+email);
		System.out.println("pw"+pw);
		
		//longin�޼ҵ尡 �ִ� Dao ȣ��
		
		MemberDAO dao=new MemberDAO();
		
		//�Է¹޾ƿ� email pw,�� dto�� ������ֱ� 
		MemberDTO dto=new MemberDTO(email, pw);
		
		//email,pw,tel,address 4���� ���� dto  ����
		MemberDTO info=dao.login(dto);
		
		//�������� ������
		if(info!=null) {
			System.out.println("�α��� ����");
			
			response.sendRedirect("Main.jsp?check=success");
		
			HttpSession session=request.getSession();
			session.setAttribute("info", info);
		}else {
			System.out.println("�α��� ����");
			response.sendRedirect("Login.jsp?check=fail");

		}

	}

}
