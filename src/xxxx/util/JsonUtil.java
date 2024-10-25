package xxxx.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class JsonUtil {

    private static final Gson GSON = new GsonBuilder()
            .setPrettyPrinting() // 可选：格式化输出
            .create();

    /**
     * 将对象转换为JSON字符串。
     *
     * @param object 要转换的对象
     * @return JSON字符串
     */
    public static String toJson(Object object) {
        return GSON.toJson(object);
    }

    /**
     * 将JSON字符串转换为指定类型的对象。
     *
     * @param json   JSON字符串
     * @param clazz  目标对象的Class
     * @param <T>    泛型类型
     * @return 指定类型的对象
     */
    public static <T> T fromJson(String json, Class<T> clazz) {
        return GSON.fromJson(json, clazz);
    }
}
