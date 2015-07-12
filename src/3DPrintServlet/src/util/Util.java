package util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * 工具类。
 * @author delin
 *
 */
public class Util {

	/**
	 * 检查字符串是否为null或为""。
	 * @param item
	 * @return
	 */
	static public boolean isEmpty(String item){
		return item == null || item.equals("");
	}
	
	/**
	 * 在字符串前后加上双引号，然后返回。
	 * @param item
	 * @return
	 */
	static public String quotation(String item){
		if(item == null){
			return null;
		}
		return "\"" + item + "\"";
	}
	
	static public boolean writeFile(String path, byte[] data){
		FileOutputStream out;
		try {
			out = new FileOutputStream(path);
			out.write(data);
			out.close();
			return true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	static public boolean mkFold(String path){
		File folder = new File(path);
		if(!folder.exists()){
			return folder.mkdir();
		}
		return folder.isDirectory();
	}
	
	public static final byte[] input2byte(InputStream inStream) {  
        ByteArrayOutputStream swapStream = new ByteArrayOutputStream();  
        byte[] buff = new byte[1024];  
        int rc = 0;  
        try {
			while ((rc = inStream.read(buff, 0, buff.length)) > 0) {  
			    swapStream.write(buff, 0, rc);  
			}
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}  
        byte[] in2b = swapStream.toByteArray();  
        return in2b;  
    }  
}
