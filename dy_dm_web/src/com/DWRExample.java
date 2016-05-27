package com;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class DWRExample implements Serializable {

	public List getList()
	{
		List list=new ArrayList();
		DemoBean db=null;
		for(int i=0;i<5;i++)
		{
			db=new DemoBean();
			db.setAge(22+i);
			db.setName("ddh"+i);		
			list.add(db);
		}
			
		
		return list;
		
	}
	
	public boolean checkUser(String name)
	{
		if("xy".equals(name))
		{
			return true;
		}else
		{
			return false;
			
		}
	}
}
