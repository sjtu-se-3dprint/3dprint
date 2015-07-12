package database;

import java.io.InputStream;
import java.util.List;

import entity.Lesson;
import entity.LessonDetail;
import net.sf.json.JSONObject;

public interface LessonServiceInterface {
	public boolean addLesson(JSONObject lesson, int userId);
	public Integer addLessonNew(JSONObject lesson, int userId);
	
	public InputStream readImage(int id);
	
	public Lesson selectLessonById(int id);
	
	// 最新教程
	public List<Lesson> selectNewLessons();
	
	// 上一篇
	public Lesson selectPreviousLessonById(int id);
	
	// 下一篇
	public Lesson selectNextLessonById(int id);
	
	// 随便读读
	public List<Lesson> selectRandomLessons();
	
	public List<LessonDetail> selectLessonDetailByLessonId(int id);
}
