package com.swp.core.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

/**
 * 描述:
 * 面向切面编程（自定义日志输出）
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-07-25 下午3:23
 */

@Component
@Aspect
@Order(3)
public class LogAspect {

    private static final Logger logger = LoggerFactory.getLogger(LogAspect.class);
    /**
     * 声明一个切入点表达式
     *
     */
    @Pointcut("execution(* com.swp..*.controller.*.*(..))")
    public void logPointCut(){};

    /**
     * 前置通知
     *
     * @param joinPoint
     */
//    @Before("logPointCut()")
//    public void beforeMethod(JoinPoint joinPoint) {
//        String className = joinPoint.getTarget().getClass().getName();
//        String methodName = joinPoint.getSignature().getName();
//        List<Object> parameters = Arrays.asList(joinPoint.getArgs());
//        if (parameters.size() > 0){
//            logger.debug("Siwanper -> [LogAspect 前置通知] 执行类方法 ：" + className + "." + methodName + "(), 参数 ： " + parameters + "，开始执行..[BEGIN]");
//        }else {
//            logger.debug("Siwanper -> [LogAspect 前置通知] 执行类方法 ：" + className + "." + methodName + "(), 无参数 ： " + "，开始执行..[BEGIN]");
//        }
//    }

    /**
     * 后置通知
     *
     * @param joinPoint
     */
//    @After("logPointCut()")
//    public void afterMethod(JoinPoint joinPoint) {
//        String className = joinPoint.getTarget().getClass().getName();
//        String methodName = joinPoint.getSignature().getName();
//        logger.debug("Siwanper -> [LogAspect 后置通知] 执行类方法 ：" + className + "." + methodName + "，执行完毕..[END]");
//    }

    /**
     *
     * 返回通知处理器
     *
     * @param joinPoint
     * @param result
     */
    @AfterReturning(value = "logPointCut()",returning = "result")
    public void afterReturingMethod(JoinPoint joinPoint, Object result){
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        List<Object> parameters = Arrays.asList(joinPoint.getArgs());
        if (parameters.size() > 0){
            logger.info("Siwanper -> [LogAspect 返回通知] 执行类方法 ：" + className + "." + methodName + "(), 参数 ： " + parameters + "，返回结果" + result);
        }else {
            logger.info("Siwanper -> [LogAspect 返回通知] 执行类方法 ：" + className + "." + methodName + "(), 无参数 ： " + "，返回结果" + result);
        }
    }

    /**
     *
     * 抛出异常通知处理器
     *
     * @param joinPoint
     * @param exception
     */
    @AfterThrowing(value = "logPointCut()",throwing = "exception")
    public void afterThrowingMethod(JoinPoint joinPoint, Exception exception){
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        List<Object> parameters = Arrays.asList(joinPoint.getArgs());
        if (parameters.size() > 0){
            logger.warn("Siwanper -> [LogAspect 异常通知] 执行类方法 ：" + className + "." + methodName + "(), 参数 ： " + parameters + "，异常信息" + exception.getMessage());
        }else {
            logger.warn("Siwanper -> [LogAspect 异常通知] 执行类方法 ：" + className + "." + methodName + "(), 无参数 ： " + "，异常信息" + exception.getMessage());
        }
    }


    /**
     * 环绕通知
     *
     * @param proceedingJoinPoint
     */
    @Around("logPointCut()")
    public Object aroundMethod(ProceedingJoinPoint proceedingJoinPoint) {
        // 执行的类名
        String className = proceedingJoinPoint.getTarget().getClass().getName();
        // 执行方法名
        String methodName = proceedingJoinPoint.getSignature().getName();
        // 传入参数
        List<Object> parameters = Arrays.asList(proceedingJoinPoint.getArgs());
        Object result = null;
        try {
            System.out.println("Siwanper -> [Aspect 环绕通知] 执行类方法 : " + className + "." + methodName + "(), 参数 : " + parameters);
            result = proceedingJoinPoint.proceed();
            System.out.println("Siwanper -> [Aspect 环绕通知] 执行类方法 : " + className + "." + methodName + "(), 执行完毕...[End]...");
        } catch (Throwable exception) {
            System.out.println("Siwanper -> [Aspect 环绕通知] 执行类方法 : " + className + "." + methodName + "(), 异常 : " + exception.getMessage());
        }

        System.out.println("Siwanper -> [Aspect 环绕通知] 执行类方法 : " + className + "." + methodName + "(), 返回结果 : " + result);
        return result;
    }

}
