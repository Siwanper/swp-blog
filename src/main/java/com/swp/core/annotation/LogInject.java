package com.swp.core.annotation;

import java.lang.annotation.*;

/**
 *
 * 自定义注解（注入 Logger 对象）
 *
 */

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface LogInject {

}
