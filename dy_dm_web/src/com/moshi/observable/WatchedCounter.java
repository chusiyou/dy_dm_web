package com.moshi.observable;

import java.util.Observable;

public class WatchedCounter extends Observable{
	
	 public void pushMessage(String message)
	    {
	        
	            // 设置改变变量
	            setChanged();

	            // 通知所有观察者，将message作为参数信息传递给观察者
	            notifyObservers(message);

	       

	    }

}
