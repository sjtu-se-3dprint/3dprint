package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class Util {

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
