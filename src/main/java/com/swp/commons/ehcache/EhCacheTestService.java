package com.swp.commons.ehcache;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
 * 描述:
 * ehcache缓存测试
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-09-10 下午3:00
 */
@Service
public class EhCacheTestService {

    @Cacheable(value = "cacheTest",key = "#param")
    public String getTimestamp(String param){
        Long timestamp = System.currentTimeMillis();
        return timestamp.toString();
    }

}
