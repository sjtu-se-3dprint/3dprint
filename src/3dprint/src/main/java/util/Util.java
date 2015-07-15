package util;

import java.io.File;

public class Util {

	static public void createFolder(String folder) throws Exception{
		if(folder == null){
			throw new Exception("Folder param is null.");
		}
		
		File f = new File(folder);
		if(!f.exists() || !f.isDirectory()){
			f.mkdirs();
		}
	}
}
