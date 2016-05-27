package com.test.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dy.bulletscreen.client.DyBulletScreenClient;
import com.dy.bulletscreen.utils.KeepAlive;
import com.dy.bulletscreen.utils.KeepGetMsg;
import com.huatech.messageremind.service.User;

public class StartListenForDY extends HttpServlet{
	
	//初始化弹幕Client
    DyBulletScreenClient danmuClient = DyBulletScreenClient.getInstance();
	//保持弹幕服务器心跳
    KeepAlive keepAlive = null;
    //获取弹幕服务器发送的所有信息
    KeepGetMsg keepGetMsg=null;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        int id = Integer.valueOf(request.getParameter("roomId"));
        String operator=request.getParameter("operator");
		HttpSession session = request.getSession();
		User user = new User();
		user.setHumanid(id);
		 response.setContentType("text/html;charset=UTF-8");
		  response.setCharacterEncoding("UTF-8");
		  request.setCharacterEncoding("UTF-8");
		if("start".equals(operator)){
			//设置需要连接和访问的房间ID，以及弹幕池分组号
	        danmuClient.init(id, -9999);
	        //保持弹幕服务器心跳
	        keepAlive = new KeepAlive();
	        keepAlive.start();
	        
	        //获取弹幕服务器发送的所有信息
	        keepGetMsg = new KeepGetMsg();
	        keepGetMsg.start();
	        session.setAttribute("userinfo", user);
		}else if ("stop".equals(operator)) {
			
			 if (keepAlive != null) {
				 keepAlive.exit = true; // 终止线程thread 
				 try {
					keepAlive.join();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
		     }
			 if (keepGetMsg != null) {
				 keepGetMsg.exit = true; // 终止线程thread 
				 try {
					 keepGetMsg.join();
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 
		     }
		}
		
		
	}

}
