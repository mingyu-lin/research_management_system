package xxxx.entity.value;

import java.util.List;

public class MessageModel
{
    private Integer code=1;// state code 1；success 0:fail
    private String msg="成功！";
    private Object object;
    private List<Object> list;
    private Integer count;
    public MessageModel() {}
    public Object getObject() {
        return object;
    }

    public List<Object> getList() {
        return list;
    }

    public void setList(List<Object> list) {
        this.list = list;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
