package com.moshi.observable;

import java.util.Collection;
import java.util.Observable;
import java.util.Observer;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.ScriptSessionFilter;

public class Watcher1 implements Observer{

	public void update(Observable o, Object arg) {
		//System.out.println("arg====="+arg);
		pushMessage(String.valueOf((arg)));
	}
	
	 private void pushMessage(final String message){
	    	//推送消息
	        Browser.withAllSessionsFiltered(new ScriptSessionFilter() {
	            public boolean match(ScriptSession session){
	            	/*
	                if (session.getAttribute("userId") == null)
	                    return false;
	                else
	                    return (session.getAttribute("userId")).equals(userId);
	                    */
	            	return true;
	            }
	        }, new Runnable(){
	            
	            private ScriptBuffer script = new ScriptBuffer();
	            
	            public void run(){
	                
	                script.appendCall("showMessage", message);
	                
	                Collection<ScriptSession> sessions = Browser

	                .getTargetSessions();
	                
	                for (ScriptSession scriptSession : sessions){
	                    scriptSession.addScript(script);
	                }
	            }
	        });
	    }

}
