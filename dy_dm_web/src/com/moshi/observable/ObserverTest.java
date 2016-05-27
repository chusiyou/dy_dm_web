package com.moshi.observable;

public class ObserverTest {

	/**
	 * @Description: TODO
	 * @param @param args   
	 * @return void  
	 * @throws
	 * @author chusiyou
	 * @date 2016-5-13
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		WatchedCounter watchedCounter = new WatchedCounter();
		
        Watcher1 watcher1 = new Watcher1();
       
        //添加观察者
        watchedCounter.addObserver(watcher1);
        //watchedCounter.addObserver(watcher2);

        //开始倒数计数
        //watchedCounter.message("");
		

	}

}
