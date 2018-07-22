package com.swp.core.injector;

import com.swp.core.annotation.MapperInject;
import com.swp.core.persistence.DelegateMapper;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.util.ReflectionUtils;

import java.lang.reflect.Field;

public class MapperInjector implements BeanPostProcessor{

    /**
     * 根据 spring 配置文件中 mybatis 中的 sqlsessionTemplate 模版
     */
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /**
     * 实例化、依赖注入完毕，在调用显示的初始化之前完成一些定制的初始化任务（前置处理器）
     * @param bean
     * @param beanName
     * @return
     * @throws BeansException
     */
    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        ReflectionUtils.doWithFields(bean.getClass(), new ReflectionUtils.FieldCallback() {
            /**
             * 通过注解（反射）创建Mapper实例
             * @param field
             * @throws IllegalArgumentException
             * @throws IllegalAccessException
             */
            public void doWith(Field field) throws IllegalArgumentException, IllegalAccessException {
                ReflectionUtils.makeAccessible(field);
                if (field.isAnnotationPresent(MapperInject.class)){
                    MapperInject annotation = field.getAnnotation(MapperInject.class);
                    Class<?> clazz = annotation.value();
                    if ("DelegateMapper".equals(field.getType().getSimpleName())){
                        field.set(bean, new DelegateMapper(sqlSessionTemplate));
                    }else {
                        field.set(bean,sqlSessionTemplate.getMapper(clazz));
                    }
                }
            }
        });
        return bean;
    }

    /**
     * 实例化、依赖注入、初始化完毕时执行（后置处理器）
     *
     * @param bean
     * @param name
     * @return
     * @throws BeansException
     */
    @Override
    public Object postProcessAfterInitialization(Object bean, String name) throws BeansException {
        return bean;
    }
}
