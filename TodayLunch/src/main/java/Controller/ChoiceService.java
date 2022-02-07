package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ChoiceDAO;
import model.ChoiceDTO;
public class ChoiceService extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ChoiceService");
		
		request.setCharacterEncoding("UTF-8");
		
		String type = request.getParameter("Value");
		
		System.out.println("type:"+type);
		
		
		
		ChoiceDAO dao = new ChoiceDAO();
		ArrayList<ChoiceDTO> choice = dao.showMessage(type);
		
		// ������ ���
		Random rd = new Random();
		int rd_num = rd.nextInt(choice.size());
		System.out.println(choice.get(rd_num).getExplain());
		request.setAttribute("food", choice.get(rd_num));
		
		//�����ð��� forward ������ �ֳ��� �ƴ�.. �� response�� ���� �������� ������ ����� ũ�� �ΰ����� �ִµ�
		// �ϳ��� ������ ���־��� sendredirect���� �ٸ� �ϳ��� �� forward��� �ֿ��� ��
		// �������� �̰����� �ִµ� ���� ū �������� �� redirect�� request, response��ü�� �ʱ�ȭ�ǰ�
		// forward�� �ʱ�ȭ ���� �ʱ⶧����request.setAttribute �� ������ ���⼭ �ҷ��� ���� �ְ� �˴ϴ�.
 		RequestDispatcher rq = request.getRequestDispatcher("ChoiceFinal.jsp");
	    rq.forward(request, response);       
		
	}

}
