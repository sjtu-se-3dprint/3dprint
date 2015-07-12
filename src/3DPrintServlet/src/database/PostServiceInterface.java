package database;
import entity.Post;
import entity.Postcomment;
import entity.Postcommentcomment;

import java.util.List;
public interface PostServiceInterface {

	// ��������
	public Boolean addPost(int userID, String firstCategory, String secondCategory, String title, String content);
	
	// ��������
	public List<Post> searchPostByCategoryStatus(String firstCategory, String secondCategory, String status);
	public Post searchPostById(int id);
	public List<Post> searchPostByUserStatus(int userID, String status);
	
	// ����¥����Ŀ��������
	public List<Post> searchPostByStatusSortByResponse(String status);
	
	// �������ӻظ�
	public Boolean addPostComment(int userID, int postID, String content);
	public Boolean addPostCommentComment(int userID, int commentId, String content);
	
	// �������ӻظ�
	public List<Postcomment> searchPostcommentByPostStatus(int postID, String status);
	
	public List<Postcommentcomment> searchPostcommentcomment(int postcommentID);
	
	// �û��Ƿ�֧�ָ�����true��֧�֣�false�����ԣ�null����
	public Boolean isSupportPost(int userID, int postID);
	
	// �û�֧�֡�����
	public Boolean addPostsupport(int userID, int postID, boolean support);
	
	// �ı�����״̬
	public Boolean updatePostStatus(int postID, String status);
}
