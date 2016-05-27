package com.test.dwr.servlet;

import java.util.Collection;

import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.proxy.dwr.Util;

import com.test.dwr.bean.Message;

public class Test{
	
	@SuppressWarnings("unchecked")
	public void sendMsg(Message u) {
		WebContext wctx = WebContextFactory.get(); // 这里是获取WebContext上下文
	    //String currentPage = wctx.getCurrentPage(); // 从上下文中获取当前页面,这些是DWRReverse Ajax
	   
	    String clientPage = "/dwr/index.jsp";
	     // 要求的必须方式
        Collection<ScriptSession> sessions = wctx.getScriptSessionsByPage(clientPage); // 在一个page中可能存在多个ScriptSessions,
        /*for (ScriptSession object : sessions)
        {
            object.getAttribute(arg0);
        } */
        Util utilAll = new Util(sessions); // Util 是DWR 在Server端模拟Brower端
        
        String  ss = u.getContext();
        utilAll.setValue("aa", ss);
       
        utilAll.setStyle("bb", "display", "inline");
        utilAll.setValue("bb", "<p>"+u.getContext()+"</p>", false);
        //ScriptBuffer sb = new ScriptBuffer();
        //这是添加页面中的javascript
        /*sb.appendScript("alert(");
        sb.appendData(ss);
        sb.appendScript(");");
        utilAll.addScript(sb);*/
        //End添加完成
        
        utilAll.addFunctionCall("divShow", u.getContext());
        
	}
	
	public static void main(String[] args)
    {
	    Test t = new Test();
	        Message  m = new Message();
	        m.setContext("hahah");
	        m.setMsgId("123");
	    t.sendMsg(m);
    }

}
