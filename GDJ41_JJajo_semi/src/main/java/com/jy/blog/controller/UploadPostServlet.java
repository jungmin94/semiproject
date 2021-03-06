package com.jy.blog.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.db.main.model.service.MainBoardService;

/**
 * Servlet implementation class UploadImgServlet
 */
@WebServlet("/blog/uploadpost.do")
public class UploadPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> allTags = new MainBoardService().getAllTags();

		ArrayList<String> array = new ArrayList<String>(allTags);
		String[] whitelist = new String[allTags.size()];
		
		for(int i = 0; i < allTags.size(); i++) {
			whitelist[i] = allTags.get(i);
		}
		
		request.setAttribute("whitelist", whitelist);
		request.setAttribute("allTags", array);
		
		System.out.println("doGet allTAgs - " + whitelist.length);

		request.getRequestDispatcher("/views/blog/blogUpload.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
