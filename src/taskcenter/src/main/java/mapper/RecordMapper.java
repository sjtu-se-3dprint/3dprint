package mapper;

import java.util.List;
import java.util.Map;

public interface RecordMapper {

	public Integer insertRecord(Map param);
	public List findRecordsByTaskId(Map param);
}
