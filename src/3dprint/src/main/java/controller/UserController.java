package controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.ArticleService;
import service.CartService;
import service.ModelService;
import service.UserService;
import service.CollectionService;

/**
 * 这个Controller负责处理所有user权限的ajax请求
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

	@Resource(name = "userServiceImpl")
	UserService userService;

	@Resource(name = "modelServiceImpl")
	ModelService modelService;
	
	@Resource(name = "collectionServiceImpl")
	CollectionService collectionService;
	
	@Resource(name = "articleServiceImpl")
	ArticleService articleService;
	
	@Resource(name = "cartServiceImpl")
	CartService cartService;

	@RequestMapping(value = "/modifyPassword.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map modifyPassword(@RequestBody Map param) {
		try {
			return initResult(true, userService.modifyPassword(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}

	/**
	 * 上传用户头像，一次共大中小三张
	 * 
	 * @param param
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/modifyUserhead.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map modifyUserhead(@RequestBody Map param, HttpServletRequest request) {
		try {
			String realPath = request.getSession().getServletContext()
					.getRealPath("/");
			param.put("realPath", realPath);
			return initResult(true, userService.modifyUserhead(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}

	/**
	 * 获取用户自己的信息
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/myInfo.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map myInfo(@RequestBody Map param) {
		return initResult(true, userService.myInfo(param));
	}

	/**
	 * 修改用户自己的资料
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/modifyInfo.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map modifyInfo(@RequestBody Map param) {
		try {
			return initResult(true, userService.modifyInfo(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 获取用户上传模型列表
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/myModels.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map myModels(@RequestBody Map param) {
		try {
			return initResult(true, modelService.myModels(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 删除用户自己上传的模型
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/deleteMyModel.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map deleteMyModel(@RequestBody Map param) {
		try {
			return initResult(true, modelService.deleteMyModel(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 模型文件上传。
	 * 在模型上传页面，用户选择了一个模型文件，先上传模型文件，
	 * 之后真正上传模型的时候，就不需要再次提交模型文件了
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/modelFileUpload.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map modelFileUpload(HttpServletRequest request) {
		try {
			return initResult(true, modelService.uploadTempModel(request));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}

	/**
	 * 模型上传
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/modelUpload.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map modelUpload(@RequestBody Map param, HttpServletRequest request) {
		try {
			String real_path = request.getSession().getServletContext()
					.getRealPath("/");
			param.put("real_path", real_path);
			return initResult(true, modelService.uploadModel(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}

	/**
	 * 模型编辑
	 * @param param
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/modelEdit.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map modelEdit(@RequestBody Map param, HttpServletRequest request) {
		try {
			String real_path = request.getSession().getServletContext()
					.getRealPath("/");
			param.put("real_path", real_path);
			return initResult(true, modelService.editModel(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 发布帖子
	 * @param param
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/articlePublish.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map articlePublish(@RequestBody Map param) {
		try {
			return initResult(true, articleService.publishArticle(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 修改帖子
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/articleEdit.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map articleEdit(@RequestBody Map param) {
		try {
			return initResult(true, articleService.editArticle(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 测试添加模型收藏功能
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addCollection.ajax", method = RequestMethod.POST,consumes = "application/json")
	@ResponseBody
	public Map addCollection(@RequestBody Map param){
	    try{
		return initResult(true, collectionService.addCollection(param)); 
	    } catch(Exception e){
	    	e.printStackTrace();
	    	return initResult(false,e.getMessage(),"");	
	    }
	}
	
	/**
	 * 取消收藏
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/removeCollection.ajax", method = RequestMethod.POST,consumes = "application/json")
	@ResponseBody
	public Map removeCollection(@RequestBody Map param) {
		try {
			return initResult(true, collectionService.removeCollection(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 模型页面加载时，判断用户是否已经收藏该模型
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/isCollection.ajax", method = RequestMethod.POST,consumes = "application/json")
	@ResponseBody
	public Map isCollection(@RequestBody Map param) {
		try {
			return initResult(true, collectionService.isCollection(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 获取模型被收藏的数目
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/getCollectionNum.ajax", method = RequestMethod.POST,consumes = "application/json")
	@ResponseBody
	public Map getCollectionNum(@RequestBody Map param) {
		try {
			return initResult(true, modelService.countCollections(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}	
	
	/**
	 * 添加购物车
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/addModelInCart.ajax", method = RequestMethod.POST,consumes = "application/json")
	@ResponseBody
	public Map addModelInCart(@RequestBody Map param) {
		try {
			return initResult(true,cartService.addModelIntoCart(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}	
	
	/**
	 * 模型页面加载时，获取用户是否将该模型加入到购物车
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/getModelAmountInCart.ajax", method = RequestMethod.POST,consumes = "application/json")
	@ResponseBody
	public Map getModelAmountInCart(@RequestBody Map param) {
		try {
			return initResult(true,cartService.getModelAmountInCart(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}	
}
