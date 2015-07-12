package database;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import sun.misc.BASE64Decoder;
import util.Util;
import entity.Collection;
import entity.Comment;
import entity.Lesson;
import entity.LessonDetail;
import entity.Mail;
import entity.Material;
import entity.Model;
import entity.Order;
import entity.Post;
import entity.Postcomment;
import entity.Postcommentcomment;
import entity.Shopcar;
import entity.User;
import entity.Userlike;

class DB implements UserServiceInterface, ModelServiceInterface,
	UserLikeCollectionCommentServiceInterface,
	ShoppingServiceInterface,
	PostServiceInterface,
	LessonServiceInterface,
	MailServiceInterface{

	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://202.120.40.25:9001/3DPrint2?user=root&password=123456&autoReconnect=true&failOverReadOnly=false";
//	private String url = "jdbc:mysql://127.0.0.1/3DPrint?user=root&password=123456&autoReconnect=true&failOverReadOnly=false";
	private Connection connection;
	
	/**
	 * ��ֹ����ߴ���DB����
	 */
	private DB(){
		connect();
	}
	
	/**
	 * ������̬DB����
	 */
	static private DB DB = new DB();
	
	/**
	 * ������ʾ�̬DB����
	 * @return
	 */
	static public DB getDB(){
		return DB;
	}
	
	/**
	 * ���ӵ����ݿ�
	 * @return
	 */
	private boolean connect(){
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return false;
		}
		try {
			connection = DriverManager.getConnection(url);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/**
	 * ִ��һ��sql��䣬������Ӱ�������
	 * @param sql
	 * @return
	 */
	private Integer executeUpdate(String sql){
		try {
			Statement statement = connection.createStatement();
			Integer count = statement.executeUpdate(sql);
			statement.close();
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
///////////////////////////////////////////////////////////////////////////////
//�û��ӿ�ʵ��
///////////////////////////////////////////////////////////////////////////////
	
	/**
	 * ����û�
	 * @param statement
	 * @param result
	 * @return
	 * @throws SQLException
	 */
	private User fillUser(Statement statement, ResultSet result)
			throws SQLException {
		User user = new User();
		user.setId(result.getInt("id"));
		user.setName(result.getString("name"));
		user.setPassword(result.getString("password"));
		user.setEmail(result.getString("email"));
		user.setTelephone(result.getString("telephone"));
		user.setQq(result.getString("qq"));
		user.setAuthority(result.getString("authority"));
		user.setStatus(result.getString("status"));
		user.setAddtime(result.getTimestamp("addtime"));
		return user;
	}
	
	/**
	 * ִ�и���sql��䣬���ص�һ�����ݣ��û���
	 * @param sql
	 * @return
	 */
	private User findUser(String sql){
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				User user =  fillUser(statement, result);
				statement.close();
				return user;
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * ִ�и���sql��䣬�����������ݣ��û���
	 * @param sql
	 * @return
	 */
	private List<User> findUsers(String sql){
		List<User> users = new ArrayList<User>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				users.add(fillUser(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}
	
	@Override
	public User searchUserByID(int id) {
		String sql = "select * from user where id=" + id + ";";
		return findUser(sql);
	}

	@Override
	public User searchUserByName(String name) {
		String sql = "select * from user where name=" + Util.quotation(name) + ";";
		return findUser(sql);
	}

	@Override
	public List<User> searchUsersByAuthorityStatus(String authority, String status) {
		String sql = "select * from user where authority=" + Util.quotation(authority)
				+ " and status=" + Util.quotation(status) + ";";
		return findUsers(sql);
	}
	
	/**
	 * ����(name,password,authority)�����û�
	 * @param name
	 * @param password
	 * @param authority
	 * @return
	 */
	private User createUserByAuthority(String name, String password, String authority){
		User user = searchUserByName(name);
		if(user != null){
			return null;
		}
		
		String sql = "insert into user(name, password, authority) values ("
				+ Util.quotation(name) + ", "
				+ Util.quotation(password) + ", "
				+ Util.quotation(authority) + ");";
		if(executeUpdate(sql) != 1){
			return null;
		}
		
		user = searchUserByName(name);
		if(user == null || !password.equals(user.getPassword())
				|| !authority.equals(user.getAuthority())){
			return null;
		}
		
		return user;
	}

	@Override
	public User createUser(String name, String password) {
		return createUserByAuthority(name, password, "user");
	}

	@Override
	public User createManager(String name, String password) {
		return createUserByAuthority(name, password, "manager");
	}

	@Override
	public Boolean updateUserInformation(int id, String email,
			String telephone, String qq) {
		String sql = "update user set email=" + Util.quotation(email)
				+ " , telephone=" + Util.quotation(telephone)
				+ " , qq=" + Util.quotation(qq)
				+ " where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}

	@Override
	public Boolean updateUserImage(int id, byte[] image) {
		String sql = "update user set image=? where id=" + id + ";";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setBinaryStream(1, new ByteArrayInputStream(image));
			int count = ps.executeUpdate();
			ps.close();
			return count == 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Boolean updateUserPassword(int id, String oldpassword,
			String newpassword) {
		String sql = "update user set password=" + Util.quotation(newpassword)
				+ " where id=" + id
				+ " and password=" + Util.quotation(oldpassword) + ";";
		return executeUpdate(sql) == 1;
	}

	@Override
	public Boolean updateUserStatus(int id, String status) {
		String sql = "update user set status=" + Util.quotation(status)
				+ " where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}
	
	@Override
	public InputStream readUserImage(int id){
		String sql = "select image from user where id=" + id + ";";
		InputStream reader = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if(result.next()){
				reader = result.getBinaryStream("image");
			}
			statement.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reader;
	}

///////////////////////////////////////////////////////////////////////////////
// ģ�ͽӿ�ʵ��
///////////////////////////////////////////////////////////////////////////////

	private Model fillModel(Statement statement, ResultSet result)
			throws SQLException {
		Model model = new Model();
		model.setId(result.getInt("id"));
		model.setName(result.getString("name"));
		model.setLength(result.getFloat("length"));
		model.setWidth(result.getFloat("width"));
		model.setHeight(result.getFloat("height"));
		model.setStyle(result.getString("style"));
		model.setCollection(result.getInt("collection"));
		model.setUserlike(result.getInt("userlike"));
		model.setDislike(result.getInt("dislike"));
		model.setDescriptrion(result.getString("description"));
		model.setImageNumber(result.getInt("imageNumber"));
		model.setBuy(result.getInt("buy"));
		model.setDownload(result.getInt("download"));
		model.setCandown(result.getBoolean("candown"));
		model.setStatus(result.getString("status"));
		model.setAddtime(result.getTimestamp("addtime"));
		User user = new User();
		user.setId(result.getInt("userID"));
		model.setUser(user);
		return model;
	}
	
	private Model findModel(String sql){
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				Model model=  fillModel(statement, result);
				statement.close();
				return model;
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private List<Model> findModels(String sql){
		List<Model> models = new ArrayList<Model>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				models.add(fillModel(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return models;
	}
	
	/**
	 * ��������Ҫ�󷵻�MySQL��䡣
	 * @param sort
	 * @return
	 */
	private String modelSortSql(String sort) {
		String sortSql = "";
		if(Util.isEmpty(sort)){
			sortSql = "";
		}else if(sort.equals("time-up")){
			sortSql = " order by addtime asc";
		}else if(sort.equals("time-down")){
			sortSql = " order by addtime desc";
		}else if(sort.equals("size-up")){
			sortSql = " order by height*width*length asc";
		}else if(sort.equals("size-down")){
			sortSql = " order by height*width*length desc";
		}
		return sortSql;
	}

	/**
	 * ����ɸѡ��������MySQL��䡣
	 * @param style
	 * @param visibility
	 * @param candown
	 * @return
	 */
	private String modelConditionSql(String style, String status,
			String candown) {
		String styleCondition = (Util.isEmpty(style) || style.equals("all")) ? "" : ("style=" + Util.quotation(style));
		String statusCondition = (Util.isEmpty(status) || status.equals("all")) ? "" : ("status=" + Util.quotation(status));
		String candownCondition;
		if(Util.isEmpty(candown)){
			candownCondition = "";
		}else if(candown.equals("yes")){
			candownCondition = "candown=true";
		}else if(candown.equals("no")){
			candownCondition = "candown=false";
		}else{
			candownCondition = "";
		}
		String allCondition = styleCondition;
		if(!Util.isEmpty(statusCondition)){
			allCondition += Util.isEmpty(allCondition) ? statusCondition : (" and " + statusCondition);
		}
		if(!Util.isEmpty(candownCondition)){
			allCondition += Util.isEmpty(allCondition) ? candownCondition : (" and " + candownCondition);
		}
		String condition = Util.isEmpty(allCondition) ? "" : " where (" + allCondition + ")";
		return condition;
	}
	
	@Override
	public Model searchModelByID(int id) {
		String sql = "select * from model where id=" + id + ";";
		return findModel(sql);
	}

	@Override
	public List<Model> searchModelsByUserStatus(int userID, String status) {
		String sql = "select * from model where userID=" + userID
				+ " and status=" + Util.quotation(status) + ";";
		return findModels(sql);
	}
	
	@Override
	public List<Model> searchModelsSort(String style, String status,
			String candown, String sort) {
		// �������������������
		String conditionSql = modelConditionSql(style, status, candown);
		String sortSql = modelSortSql(sort);
		String sql = "select * from model " + conditionSql + sortSql + ";";
		return findModels(sql);
	}

	@Override
	public Model createModel(int userID, String name) {
		String sql = "insert into model(userID, name) values(" + userID
				+ "," + Util.quotation(name) + ");";
		if(executeUpdate(sql) != 1){
			return null;
		}
		sql = "select * from model where userID=" + userID
				+ " and name=" + Util.quotation(name) + ";";
		return findModel(sql);
	}

	@Override
	public Boolean updateModelInformation(int id, String name, float length,
			float width, float height, String style, String description) {
		String sql = "update model set name=" + Util.quotation(name)
				+ ", length=" + length
				+ ", width=" + width
				+ ", height=" + height
				+ ", style=" + Util.quotation(style)
				+ ", description=" + Util.quotation(description)
				+ " where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}

	@Override
	public Boolean updateModelFile(int id, byte[] file) {
		String sql = "update model set file=? where id=" + id + ";";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setBinaryStream(1, new ByteArrayInputStream(file));
			int count = ps.executeUpdate();
			ps.close();
			return count == 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Boolean createModelImage(int id, byte[] image) {
		Model model = searchModelByID(id);
		if(model == null){
			return false;
		}
		int number = model.getImageNumber() + 1;
		String sql = "insert into modelimage(modelID, number, image) values ("
				+ id + "," + number + ", ?);";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setBinaryStream(1, new ByteArrayInputStream(image));
			int count = ps.executeUpdate();
			ps.close();
			if(count != 1){
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			sql = "update modelimage set image=? where modelID=" + id + " and number=" + number + ";";
			try{
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setBinaryStream(1, new ByteArrayInputStream(image));
				int count = ps.executeUpdate();
				ps.close();
				if(count != 1){
					return false;
				}
			}catch (SQLException ee) {
				ee.printStackTrace();
			}
		}
		
		sql = "update model set imageNumber=imageNumber+1 where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}
	
	@Override
	public Boolean deleteModelImage(int id, int seq){
		Model model = searchModelByID(id);
		if(model == null){
			return false;
		}
		int number = model.getImageNumber();
		for(int i=seq+1; i<=number; i++){
			InputStream reader = readModelImage(id, i);
			byte[] image = Util.input2byte(reader);
			try {
				String sql = "update modelimage set image=? where modelID=" + id + " and number=" + (i-1) + ";";
				PreparedStatement ps = connection.prepareStatement(sql);
				ps.setBinaryStream(1, new ByteArrayInputStream(image));
				int count = ps.executeUpdate();
				ps.close();
				if(count != 1){
					return false;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		String sql = "delete from modelimage where modelID=" + id + " and number=" + number;
		if(executeUpdate(sql) != 1){
			return false;
		}
		sql = "update model set imageNumber=imageNumber-1 where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}

	@Override
	public Boolean updateModelStatus(int id, String status) {
		String sql = "update model set status=" + Util.quotation(status)
				+ " where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}
	
	@Override
	public InputStream readModelImage(int id, int number){
		String sql = "select image from modelimage where modelID=" + id
				+ " and number=" + number + ";";
		InputStream reader = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if(result.next()){
				reader = result.getBinaryStream("image");
			}
			statement.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reader;
	}
	
	@Override
	public InputStream readModelFile(int id){
		String sql = "select file from model where id=" + id + ";";
		InputStream reader = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if(result.next()){
				reader = result.getBinaryStream("file");
			}
			statement.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reader;
	}
	
///////////////////////////////////////////////////////////////////////////////
//�û����ޡ��ղء����۽ӿ�ʵ��
///////////////////////////////////////////////////////////////////////////////
	
	private Userlike fillUserlike(Statement statement, ResultSet result)
			throws SQLException {
		Userlike userlike = new Userlike();
		userlike.setId(result.getInt("id"));
		userlike.setModelID(result.getInt("modelID"));
		userlike.setUserID(result.getInt("userID"));
		userlike.setUserlike(result.getBoolean("userlike"));
		userlike.setAddtime(result.getTimestamp("addtime"));
		return userlike;
	}
	
	private Collection fillCollection(Statement statement, ResultSet result)
			throws SQLException {
		Collection collection = new Collection();
		collection.setId(result.getInt("id"));
		collection.setModelID(result.getInt("modelID"));
		collection.setUserID(result.getInt("userID"));
		collection.setAddtime(result.getTimestamp("addtime"));
		return collection;
	}
	
	private Comment fillComment(Statement statement, ResultSet result)
			throws SQLException {
		Comment comment = new Comment();
		comment.setId(result.getInt("id"));
		comment.setComment(result.getString("comment"));
		Model model = new Model();
		model.setId(result.getInt("modelID"));
		comment.setModel(model);
		User user = new User();
		user.setId(result.getInt("userID"));
		comment.setUser(user);
		comment.setStatus(result.getString("status"));
		comment.setAddtime(result.getTimestamp("addtime"));
		return comment;
	}
	
	private List<Collection> findCollections(String sql){
		List<Collection> collections = new ArrayList<Collection>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				collections.add(fillCollection(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return collections;
	}
	
	private List<Comment> findComments(String sql){
		List<Comment> comments = new ArrayList<Comment>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				comments.add(fillComment(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comments;
	}
	
	@Override
	public Boolean isUserlike(int userID, int modelID) {
		String sql = "select * from userlike where userID=" + userID
				+ " and modelID=" + modelID + ";";
		Userlike userlike = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				userlike = fillUserlike(statement, result);
			}
			statement.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(userlike == null){
			return null;
		}
		return userlike.getUserlike();
	}

	@Override
	public Boolean isCollection(int userID, int modelID) {
		String sql = "select * from collection where userID=" + userID
				+ " and modelID=" + modelID + ";";
		Collection collection = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				collection = fillCollection(statement, result);
			}
			statement.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return collection != null;
	}

	@Override
	public Boolean addUserlike(int userID, int modelID, boolean like) {
		String sql = "insert into userlike(userID, modelID, userlike) values("
				+ userID + "," + modelID + "," + like + ");";
		Integer count = executeUpdate(sql);
		if(count == null || count != 1){
			return false;
		}
		if(like){
			sql = "update model set userlike=userlike+1 where id=" + modelID + ";";
		}else{
			sql = "update model set dislike=dislike+1 where id=" + modelID + ";";
		}
		executeUpdate(sql);
		return true;
	}

	@Override
	public Boolean cancelUserlike(int userID, int modelID) {
		Boolean like = isUserlike(userID, modelID);
		if(like == null){
			return false;
		}
		
		String sql = "delete from userlike where userID=" + userID + " and modelID=" + modelID + ";";
		Integer count = executeUpdate(sql);
		if(count == null || count != 1){
			return false;
		}
		
		if(like){
			sql = "update model set userlike=userlike-1 where id=" + modelID + ";";
		}else{
			sql = "update model set dislike=dislike-1 where id=" + modelID + ";";
		}
		executeUpdate(sql);
		return true;
	}

	@Override
	public Boolean addCollection(int userID, int modelID) {
		String sql = "insert into collection(userID, modelID) values("
				+ userID + "," + modelID + ");";
		Integer count = executeUpdate(sql);
		if(count == null || count != 1){
			return false;
		}
		sql = "update model set collection=collection+1 where id=" + modelID + ";";
		executeUpdate(sql);
		return true;
	}

	@Override
	public Boolean cancelColletion(int userID, int modelID) {
		String sql = "delete from collection where userID=" + userID + " and modelID=" + modelID + ";";
		Integer count = executeUpdate(sql);
		if(count == null || count != 1){
			return false;
		}
		sql = "update model set collection=collection-1 where id=" + modelID + ";";
		executeUpdate(sql);
		return true;
	}

	@Override
	public Boolean addComment(int userID, int modelID, String comment) {
		String sql = "insert into comment(userID, modelID, comment) values("
				+ userID + "," + modelID + "," + Util.quotation(comment) + ");";
		return executeUpdate(sql) == 1;
	}

	@Override
	public List<Comment> searchCommentByModelStatus(int modelID, String status) {
		String sql = "select * from comment where modelID=" + modelID
				+ " and status=" + Util.quotation(status)
				+ " order by addtime desc;";
		return findComments(sql);
	}
	
	@Override
	public List<Comment> searchCommentByStatus(String status){
		String sql = "select * from comment where "
				+ " status=" + Util.quotation(status)
				+ " order by addtime desc;";
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByTime(String status,
			boolean asc) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " order by addtime " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByModelID(String status,
			boolean asc) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " order by modelID " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByCommenterID(String status,
			boolean asc) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " order by userID " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByTimeLimitByModel(
			String status, boolean asc, int modelID) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " and modelID=" + modelID
				+ " order by addtime " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByModelIDLimitByModel(
			String status, boolean asc, int modelID) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " and modelID=" + modelID
				+ " order by modelID " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByCommenterIDLimitByModel(
			String status, boolean asc, int modelID) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " and modelID=" + modelID
				+ " order by userID " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByTimeLimitByUser(
			String status, boolean asc, int userID) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " and userID=" + userID
				+ " order by addtime " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByModelIDLimitByUser(
			String status, boolean asc, int userID) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " and userID=" + userID
				+ " order by modelID " + (asc?"asc":"desc");
		return findComments(sql);
	}

	@Override
	public List<Comment> searchCommentByStatusOrderByCommenterIDLimitByUser(
			String status, boolean asc, int userID) {
		String sql = "select * from comment where status=" + Util.quotation(status)
				+ " and userID=" + userID
				+ " order by userID " + (asc?"asc":"desc");
		return findComments(sql);
	}
	
	@Override
	public Boolean updateCommentStatus(int id, String status){
		String sql = "update comment set status=" + Util.quotation(status)
				+ " where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}
	
	@Override
	public List<Collection> searchCollectionsByUserID(int userID){
		String sql = "select * from collection where userID=" + userID + ";";
		return findCollections(sql);
	}

///////////////////////////////////////////////////////////////////////////////
//����ӿ�ʵ��
///////////////////////////////////////////////////////////////////////////////

	private Shopcar fillShopcar(Statement statement, ResultSet result)
			throws SQLException {
		Shopcar shopcar = new Shopcar();
		shopcar.setId(result.getInt("id"));
		User user = new User();
		user.setId(result.getInt("userID"));
		shopcar.setUser(user);
		Model model = new Model();
		model.setId(result.getInt("modelID"));
		shopcar.setModel(model);
		shopcar.setNumber(result.getInt("number"));
		shopcar.setAddtime(result.getTimestamp("addtime"));
		return shopcar;
	}

	private Material fillMaterial(Statement statement, ResultSet result)
			throws SQLException {
		Material material = new Material();
		material.setId(result.getInt("id"));
		material.setName(result.getString("name"));
		material.setAccuracy(result.getFloat("accuracy"));
		material.setIntensity(result.getFloat("intensity"));
		material.setPrice(result.getFloat("price"));
		material.setSmooth(result.getFloat("smooth"));
		material.setDescription(result.getString("description"));
		material.setStatus(result.getString("status"));
		material.setAddtime(result.getTimestamp("addtime"));
		return material;
	}
	
	private Order fillOrder(Statement statement, ResultSet result)
			throws SQLException {
		Order order = new Order();
		order.setId(result.getInt("id"));
		User user = new User();
		user.setId(result.getInt("userID"));
		order.setUser(user);
		Model model = new Model();
		model.setId(result.getInt("modelID"));;
		order.setModel(model);
		Material material = new Material();
		material.setId(result.getInt("materialID"));
		order.setMaterial(material);
		order.setNumber(result.getInt("number"));
		order.setPrice(result.getFloat("price"));
		order.setStatus(result.getString("status"));
		order.setAddtime(result.getTimestamp("addtime"));
		return order;
	}
	
	private Order findOrder(String sql){
		Order order = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				order = fillOrder(statement, result);
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return order;
	}

	private List<Order> findOrders(String sql){
		List<Order> orders = new ArrayList<Order>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				orders.add(fillOrder(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orders;
	}
	private Material findMaterial(String sql){
		Material material = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				material = fillMaterial(statement, result);
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return material;
	}
	
	private List<Material> findMaterials(String sql){
		List<Material> materials = new ArrayList<Material>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				materials.add(fillMaterial(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return materials;
	}
	
	private Shopcar findShopcar(String sql){
		Shopcar shopcar = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				shopcar = fillShopcar(statement, result);
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return shopcar;
	}
	private List<Shopcar> findShopcars(String sql){
		List<Shopcar> shopcars = new ArrayList<Shopcar>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				shopcars.add(fillShopcar(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return shopcars;
	}
	
	
	@Override
	public Boolean addShopcar(int userID, int modelID, int number) {
		String sql = "insert into shopcar(userID, modelID, number) values("+ userID
				+ "," + modelID + "," + number + ");";
		return executeUpdate(sql) == 1;
	}

	@Override
	public Boolean cancelShopcar(int id) {
		String sql = "delete from shopcar where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}

	@Override
	public List<Shopcar> searchShopcarsByUser(int userID) {
		String sql = "select * from shopcar where userID=" + userID + ";";
		return findShopcars(sql);
	}
	
	@Override
	public Shopcar searchShopcarByID(int id){
		String sql = "select * from shopcar where id=" + id + ";";
		return findShopcar(sql);
	}

	@Override
	public List<Material> searchMaterialsByStatus(String status) {
		String sql = "select * from material where status=" + Util.quotation(status) + ";";
		return findMaterials(sql);
	}
	
	@Override
	public Material searchMaterialByID(int id){
		String sql = "select * from material where id=" + id + ";";
		return findMaterial(sql);
	}

	@Override
	public Boolean addOrder(int userID, int modelID, int materialID,
			int number, float price, String status) {
		String sql = "insert into orders(userID, modelID, materialID, number, price, status) values("
				+ userID + "," + modelID + "," + materialID + "," + number
				+ ", " + price + "," + Util.quotation(status) + ");";
		return executeUpdate(sql)==1;
	}
	
	@Override
	public List<Order> searchOrdersByStatus(String status){
		String sql = "select * from orders where status=" + Util.quotation(status) + ";";
		return findOrders(sql);
	}
	
	@Override
	public List<Order> searchOrdersByUserStatus(int userID, String status){
		String sql = "select * from orders where status=" + Util.quotation(status)
				+ " and userID=" + userID + ";";
		return findOrders(sql);
	}
	
	@Override
	public Boolean updateOrderStatus(int id, String status){
		String sql = "update orders set status=" + Util.quotation(status) + " where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}
	
	@Override
	public Boolean updateOrderPriceStatus(int id, float price, String status){
		String sql = "update orders set status=" + Util.quotation(status)
				+ ", price=" + price + " where id=" + id + ";";
		return executeUpdate(sql) == 1;
	}
	
	@Override
	public Boolean updateOrderStatusByUser(int id, int userID, String status){
		String sql = "update orders set status=" + Util.quotation(status) + " where id=" + id
				+ " and userID=" + userID + ";";
		return executeUpdate(sql) == 1;
	}

///////////////////////////////////////////////////////////////////////////////
//���ӽӿ�ʵ��
///////////////////////////////////////////////////////////////////////////////
	
	private Post fillPost(Statement statement, ResultSet result)
			throws SQLException {
		Post post = new Post();
		post.setId(result.getInt("id"));
		User user = new User();
		user.setId(result.getInt("userID"));
		post.setUser(user);
		post.setFirstCategory(result.getString("firstCategory"));
		post.setSecondCategory(result.getString("secondCategory"));
		post.setTitle(result.getString("title"));
		post.setContent(result.getString("content"));
		post.setResponse(result.getInt("response"));
		post.setSupport(result.getInt("support"));
		post.setOpposite(result.getInt("opposite"));
		post.setStatus(result.getString("status"));
		post.setAddtime(result.getTimestamp("addtime"));
		return post;
	}
	
	private Postcomment fillPostcomment(Statement statement, ResultSet result)
			throws SQLException {
		Postcomment postcomment = new Postcomment();
		postcomment.setId(result.getInt("id"));
		postcomment.setContent(result.getString("content"));
		postcomment.setFloor(result.getInt("floor"));
		User user = new User();
		user.setId(result.getInt("userID"));
		postcomment.setUser(user);
		Post post = new Post();
		post.setId(result.getInt("postID"));
		postcomment.setPost(post);
		postcomment.setStatus(result.getString("status"));
		postcomment.setAddtime(result.getTimestamp("addtime"));
		postcomment.setResponse(result.getInt("response"));
		return postcomment;
	}
	
	private Postcommentcomment fillPostcommentcomment(Statement statement, ResultSet result)
			throws SQLException {
		Postcommentcomment postcommentcomment = new Postcommentcomment();
		postcommentcomment.setId(result.getInt("id"));
		postcommentcomment.setContent(result.getString("content"));
		postcommentcomment.setFloor(result.getInt("floor"));
		User user = new User();
		user.setId(result.getInt("userID"));
		postcommentcomment.setUser(user);
		Postcomment postcomment = new Postcomment();
		postcomment.setId(result.getInt("postcommentID"));
		postcommentcomment.setPostcomment(postcomment);
		postcommentcomment.setAddtime(result.getTimestamp("addtime"));
		return postcommentcomment;
	}
	
	private Postcomment findPostcomment(String sql){
		Postcomment postcomment = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				postcomment = fillPostcomment(statement, result);
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return postcomment;
	}
	
	private List<Postcomment> findPostcomments(String sql){
		List<Postcomment> postcomments = new ArrayList<Postcomment>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				postcomments.add(fillPostcomment(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return postcomments;
	}
	
	private List<Postcommentcomment> findPostcommentcomments(String sql){
		List<Postcommentcomment> postcomments = new ArrayList<Postcommentcomment>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				postcomments.add(fillPostcommentcomment(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return postcomments;
	}
	
	private Post findPost(String sql){
		Post post = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				post = fillPost(statement, result);
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return post;
	}
	
	private List<Post> findPosts(String sql){
		List<Post> posts = new ArrayList<Post>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				posts.add(fillPost(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return posts;
	}
	
	@Override
	public Boolean addPost(int userID, String firstCategory,
			String secondCategory, String title, String content) {
		String sql = "insert into post(userID,firstCategory,secondCategory,title,content) values("
				+ userID + "," + Util.quotation(firstCategory) + "," + Util.quotation(secondCategory)
				+ "," + Util.quotation(title) + ", " + Util.quotation(content) + ");";
		return executeUpdate(sql) == 1;
	}

	@Override
	public List<Post> searchPostByCategoryStatus(String firstCategory,
			String secondCategory, String status) {
		String sql = "select * from post where firstCategory=" + Util.quotation(firstCategory)
				+ " and secondCategory=" + Util.quotation(secondCategory)
				+ " and status=" + Util.quotation(status)
				+ " order by addtime desc;";
		return findPosts(sql);
	}

	@Override
	public List<Post> searchPostByStatusSortByResponse(String status) {
		String sql = "select * from post where status=" + Util.quotation(status)
				+ " order by response desc;";
		return findPosts(sql);
	}

	@Override
	public Post searchPostById(int id) {
		String sql = "select * from post where id=" + id + ";";
		return findPost(sql);
	}

	@Override
	public Boolean addPostCommentComment(int userID, int commentID, String content) {
		String sql = "select * from postcomment where id=" + commentID + ";";
		Postcomment postcomment = findPostcomment(sql);
		if(postcomment == null){
			return false;
		}
		
		int floor = postcomment.getResponse() + 1;
		
		content = content.replaceAll("\"", "\\\\\"");
		content = content.replaceAll("'", "\\'");
		System.out.println(content);
		
		sql = "insert into postcommentcomment(userID, postcommentID, content, floor) values("
				+ userID + "," + commentID + "," + Util.quotation(content) + "," + floor + ");";
		if(executeUpdate(sql) == 1){
			sql = "update postcomment set response=response+1 where id=" + commentID + ";";
			for(int j=0; j<3; j++){
				if(executeUpdate(sql) == 1){
					return true;
				}
			}
		}
		sql = "delete from postcommentcomment where postcommentID=" + commentID + " and floor=" + floor + ";";
		executeUpdate(sql);
		return false;
	}
	
	@Override
	public Boolean addPostComment(int userID, int postID, String content) {
		Post post = searchPostById(postID);
		if(post == null){
			return false;
		}
		
		int floor = post.getResponse() + 1;

		content = content.replaceAll("\"", "\\\\\"");
		content = content.replaceAll("'", "\\'");
		System.out.println(content);
		
		// ����ظ�
		String sql = "insert into postcomment(userID, postID, content, floor) values("
				+ userID + "," + postID + "," + Util.quotation(content) + "," + floor + ");";
		if(executeUpdate(sql) == 1){
			// ����¥��
			sql = "update post set response=response+1 where id=" + postID + ";";
			for(int j=0; j<3; j++){
				if(executeUpdate(sql) == 1){
					return true;
				}
			}
		}
		// ����¥��ʧ���ˣ�ɾ���Ѿ�����Ļظ�
		sql = "delete from postcomment where postID=" + postID + " and floor=" + floor + ";";
		executeUpdate(sql);
		return false;
	}
	
	private Postcomment searchPostcommentByFloor(int id){
		String sql = "select * from postcomment where id=" + id + ";";
		return findPostcomment(sql);
	}

	@Override
	public List<Postcomment> searchPostcommentByPostStatus(int postID,
			String status) {
		String sql = "select * from postcomment where postID=" + postID + " and status=" + Util.quotation(status)
				+ " order by floor asc;";
		return findPostcomments(sql);
	}
	
	@Override
	public List<Postcommentcomment> searchPostcommentcomment(int postcommentID){
		String sql = "select * from postcommentcomment where postcommentID=" + postcommentID + " order by floor asc;";
		return findPostcommentcomments(sql);
	}

	@Override
	public Boolean isSupportPost(int userID, int postID) {
		String sql = "select * from postsupport where userID=" + userID + " and postID=" + postID + ";";
		Boolean support = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				support = result.getBoolean("support");
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return support;
	}

	@Override
	public Boolean addPostsupport(int userID, int postID, boolean support) {
		Boolean isSupport = isSupportPost(userID, postID);
		if(isSupport != null){
			return false;
		}
		
		String sql = "insert into postsupport(userID, postID, support) values("
				+ userID + "," + postID + "," + support + ");";
		Boolean success = executeUpdate(sql) == 1;
		if(success == null || !success){
			return false;
		}
		
		if(support){
			sql = "update post set support=support+1 where id=" + postID + ";";
		}else{
			sql = "update post set opposite=opposite+1 where id=" + postID + ";";
		}
		executeUpdate(sql);
		return true;
	}

	@Override
	public List<Post> searchPostByUserStatus(int userID, String status){
		String sql = "select * from post where userID=" + userID + " and status=" + Util.quotation(status) + ";";
		return findPosts(sql);
	}
	
	@Override
	public Boolean updatePostStatus(int postID, String status){
		String sql = "update post set status=" + Util.quotation(status) + " where id=" + postID + ";";
		return executeUpdate(sql) == 1;
	}


	@Override
	public Integer addLessonNew(JSONObject lesson, int userId) {
		String sql = "insert into lesson(title,userID,content) values(?,?,?);";
		PreparedStatement pstmt;
		try {
			pstmt = (PreparedStatement) connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, lesson.getString("title"));
			pstmt.setInt(2, userId);
			pstmt.setString(3, lesson.getString("content"));
			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys(); 
			if(rs.next()){
				return rs.getInt(1);
			}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@Override
	public boolean addLesson(JSONObject lesson, int userId) {
		String sql = "insert into lesson(title,userID) values(?,?);";

		int id = -1;
		PreparedStatement pstmt;
		try {
			pstmt = (PreparedStatement) connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, lesson.getString("title"));
			pstmt.setInt(2, userId);
			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys(); 
			if (rs.next()) {
				id = rs.getInt(1);//取得ID
			}  
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(id);
		JSONArray content = lesson.getJSONArray("content");
		for(int i=0; i<content.size(); i++){
			JSONObject obj = content.getJSONObject(i);
			if("txt".indexOf(obj.getString("type")) == 0){
				sql = "insert into lesson_detail (detailType,detailOrder,txt,lessonID)values("
						+ Util.quotation(obj.getString("type")) + "," + i + "," 
						+ Util.quotation(obj.getString("txt")) + "," + id + ");";
				if(1 != executeUpdate(sql)){
					return false;
				}
			}else if("img".indexOf(obj.getString("type")) == 0){
				sql = "insert into lesson_detail(detailType,detailOrder,img,lessonID) values(?,?,?,?)";
				try{
					String img = obj.getString("src");
					if(img.indexOf("data:image") != 0){
						return false;
					}
					int base64Index = img.indexOf("base64,");
					if(base64Index < 0){
						return false;
					}
					img = img.substring(base64Index + "base64,".length());
					BASE64Decoder decoder = new BASE64Decoder();
					byte[] image;
					try {
						image = decoder.decodeBuffer(img);
					} catch (IOException e) {
						e.printStackTrace();
						return false;
					}
					PreparedStatement ps = connection.prepareStatement(sql);
					ps.setString(1, obj.getString("type"));
					ps.setInt(2, i);
					ps.setBinaryStream(3, new ByteArrayInputStream(image));
					ps.setInt(4, id);
					int count = ps.executeUpdate();
					ps.close();
					if(count != 1){
						return false;
					}
				}catch (SQLException ee) {
					ee.printStackTrace();
				}
			}else if("video".indexOf(obj.getString("type")) == 0){
				sql = "insert into lesson_detail (detailType,detailOrder,videoUrl,lessonID)values("
						+ Util.quotation(obj.getString("type")) + "," + i + "," 
						+ Util.quotation(obj.getString("url")) + "," + id + ");";
				if(1 != executeUpdate(sql)){
					return false;
				}
			}
		}
		return true;
	}
	
	@Override
	public InputStream readImage(int id){
		String sql = "select img from lesson_detail where id=" + id + ";";
		InputStream reader = null;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			
			if(result.next()){
				reader = result.getBinaryStream("img");
			}
			statement.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reader;
	}

	@Override
	public Lesson selectLessonById(int id) {
		String sql = "select * from lesson where id=" + id + ";";
		return findLesson(sql);
	}

	@Override
	public List<LessonDetail> selectLessonDetailByLessonId(int id) {
		String sql = "select * from lesson_detail where lessonID=" + id;
		return findLessonDetails(sql);
	}
	
	private List<LessonDetail> findLessonDetails(String sql){
		List<LessonDetail> details = new ArrayList<LessonDetail>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				LessonDetail detail =  fillLessonDetail(statement, result);
				details.add(detail);
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return details;
	}
	
	private LessonDetail fillLessonDetail(Statement statement, ResultSet result)throws SQLException{
		LessonDetail lesson = new LessonDetail();
		lesson.setAddtime(result.getTimestamp("addtime"));
		lesson.setId(result.getInt("id"));
		lesson.setOrder(result.getInt("detailOrder"));
		lesson.setTxt(result.getString("txt"));
		lesson.setType(result.getString("detailType"));
		lesson.setVideoUrl(result.getString("videoUrl"));
		return lesson;
	}
	
	private Lesson findLesson(String sql){
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				Lesson lesson =  fillLesson(statement, result);
				statement.close();
				return lesson;
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private Lesson fillLesson(Statement statement, ResultSet result)
			throws SQLException {
		Lesson lesson = new Lesson();
		lesson.setAddtime(result.getTimestamp("addtime"));
		lesson.setId(result.getInt("id"));
		lesson.setUserID(result.getInt("userID"));
		lesson.setTitle(result.getString("title"));
		lesson.setContent(result.getString("content"));
		return lesson;
	}
	
	private List<Lesson> findLessons(String sql){
		List<Lesson> lessons = new ArrayList<Lesson>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				lessons.add(fillLesson(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lessons;
	}

	@Override
	public List<Lesson> selectNewLessons() {
		String sql = "select * from lesson order by addtime desc limit 4;";
		return findLessons(sql);
	}

	@Override
	public Lesson selectPreviousLessonById(int id) {
		String sql = "select * from lesson where id=(select max(id) from lesson where id < " + id  + ");";
		return findLesson(sql);
	}

	@Override
	public Lesson selectNextLessonById(int id) {
		String sql = "select * from lesson where id=(select min(id) from lesson where id > " + id  + ");";
		return findLesson(sql);
	}

	@Override
	public List<Lesson> selectRandomLessons() {
		String sql = "select min(id) from lesson;";
		int min = executeQuery(sql);
		sql = "select max(id) from lesson;";
		int max = executeQuery(sql);
		List<Lesson> list = new ArrayList<Lesson>();
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		for(int i=0; i<20; i++){
			int r = (int)(Math.random()*(max-min)+min);
			sql = "select * from lesson where id=" + r + ";";
			Lesson lesson = findLesson(sql);
			if(lesson != null && !map.containsKey(lesson.getId())){
				map.put(lesson.getId(), 1);
				list.add(lesson);
				if(list.size() >= 4){
					return list;
				}
			}
		}
		return list;
	}
	
	private int executeQuery(String sql){
		int ret = 0;
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			if(result.next()){
				ret = result.getInt(1);
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ret;
	}

	@Override
	public Boolean addMail(int senderID, int receiverID, String title,
			String content) {
		String sql = "insert into mail(senderID,receiverID,title,content) values(?,?,?,?);";
		int id = -1;
		PreparedStatement pstmt;
		try {
			pstmt = (PreparedStatement) connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, senderID);
			pstmt.setInt(2, receiverID);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys(); 
			if (rs.next()) {
				id = rs.getInt(1);//取得ID
			}  
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public List<Mail> selectMails(int receiverID, boolean isRead) {
		String sql = "select * from mail where receiverID=" + receiverID + " and isRead=" + isRead + ";";
		return findMails(sql);
	}
	
	private List<Mail> findMails(String sql){
		List<Mail> mails = new ArrayList<Mail>();
		try {
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(sql);
			while(result.next()){
				mails.add(fillMail(statement, result));
			}
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mails;
	}
	
	private Mail fillMail(Statement statement, ResultSet result)
			throws SQLException {
		Mail mail = new Mail();
		mail.setAddtime(result.getTimestamp("addtime"));
		mail.setId(result.getInt("id"));
		mail.setIsRead(result.getBoolean("isRead"));
		mail.setTitle(result.getString("title"));
		mail.setContent(result.getString("content"));
		mail.setReceiverID(result.getInt("receiverID"));
		mail.setSenderID(result.getInt("senderID"));
		return mail;
	}

	@Override
	public Boolean changeReadStatus(int mailID, boolean isRead) {
		String sql = "update mail set isRead=" + isRead + " where id=" + mailID + ";";
		return executeUpdate(sql) == 1;
	}
}
