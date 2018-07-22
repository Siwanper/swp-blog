package com.swp.core.annotation;

import java.lang.annotation.*;

/**
 * 自定义注解（注入Mapper对象）
 */

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface MapperInject {

    /**
     * 对象类型（默认 Object 则认为是 DelegateMapper 类型）
     *
     * @return Class<?> 对象类型</>
     */
    Class<?> value() default java.lang.Object.class;

}
