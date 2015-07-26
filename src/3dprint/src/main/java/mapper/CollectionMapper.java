/**
 * 
 */
package mapper;

import java.util.List;
import java.util.Map;

/**
 * 对应收藏表collection
 * 
 */
public interface CollectionMapper {

	/**
	 * 根据用户id查找收藏
	 */
    public List findCollectionByUser(Map map);
    
     /*
      * 根据模型id查找收藏数目
      */
    public int findCollectionByModel(Map map);
    
    /*
     * 根据用户id和模型id判断是否已经收藏
     */
    
    public  Map isCollection(Map map);
    
    /*
     * 添加收藏记录
     */
    public Integer addCollection(Map map);
    
    /**
     * 用户恢复收藏该模型
     * @param map
     * @return int
     */
    public Integer recoverCollection(Map map);
    /*
     * 用户取消收藏，输入为用户和模型
     */
    public Integer removeCollection(Map map);

}


	
