package service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import mapper.ModelMapper;
import service.ModelService;

@Service("modelServiceImpl")
public class ModelServiceImpl implements ModelService {
	
	@Resource(name = "modelMapper")
	ModelMapper modelMapper;
	
	public List totalModelType(Map param) {
		List modelTypeList = modelMapper.getTotalModelType(param);
		return modelTypeList;
	}

}
