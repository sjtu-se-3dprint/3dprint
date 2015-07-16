package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import org.apache.commons.codec.binary.Base64;

public class Util {
	

	static public void decodeBase64ImageAndSave(String base64Image, String fileLocation) throws Exception{
		Base64 decoder = new Base64();
		String flag = "base64,";
		int location = base64Image.indexOf(flag);
		if (location < 0) {
			return;
		}
		base64Image = base64Image.substring(location + flag.length());
		byte[] bytes = decoder.decode(base64Image);
		FileOutputStream os = new FileOutputStream(fileLocation);
		os.write(bytes);
		os.close();
	}

	static public void createFolder(String folder) throws Exception {
		if (folder == null) {
			throw new Exception("Folder param is null.");
		}

		File f = new File(folder);
		if (!f.exists() || !f.isDirectory()) {
			f.mkdirs();
		}
	}

	static public void copyFile(String oldFile, String newFile)
			throws Exception {
		File modelFile = new File(oldFile);
		if (!modelFile.exists() || !modelFile.isFile()) {
			throw new Exception("文件找不到");
		}

		FileInputStream is = new FileInputStream(oldFile);
		FileOutputStream os = new FileOutputStream(newFile);
		byte[] b = new byte[1024 * 5];
		int len;
		while ((len = is.read(b)) != -1) {
			os.write(b, 0, len);
		}
		os.flush();
		os.close();
		is.close();
	}
}
