package com.sist.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sist.dao.UserinfoDAO;

public class UpdateUserimgAction implements SistAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path=request.getRealPath("images/userimg");
		MultipartRequest multi=new MultipartRequest(request, path, 1024*1024*5, "utf-8",
				new DefaultFileRenamePolicy());
		String fname="";
		if(multi.getFile("imgInput")!=null){
			fname=multi.getFile("imgInput").getName();
		}

		UserinfoDAO dao=UserinfoDAO.getInstance();
		HttpSession session = request.getSession();
		int userno=Integer.parseInt(session.getAttribute("userno")+"");
		int re_img=dao.updateUserimg(userno, fname);
		request.setAttribute("re_img", re_img);
		
		return "detailUserinfo.do";
	}

}
