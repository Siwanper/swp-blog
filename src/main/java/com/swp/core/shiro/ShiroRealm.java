package com.swp.core.shiro;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

/**
 * 描述:
 * 域 realm 实现类
 *
 * @version 1.0.0
 * @outhor ios
 * @create 2018-09-10 下午4:44
 */
public class ShiroRealm extends AuthorizingRealm {

    /**
     *
     * 为当前登录的Subject授予角色的权限
     *
     * 该方法的调用时机为：需要授权资源被访问时 每次访问需授权资源时都会执行改方法中的逻辑，如果用户瘦哦圈内容被缓存，则不会重复调用该方法。
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    /**
     * 验证当前登录的Subject 在subject.login(AuthenticationToken)时调用该方法
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // 获取给予用户名和密码的令牌
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) authenticationToken;
        // 交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配，
        System.out.printf("username =============== "+usernamePasswordToken.getUsername());
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(usernamePasswordToken.getUsername(),usernamePasswordToken.getPassword(),getName());
        clearCache(authenticationInfo.getPrincipals());
        return authenticationInfo;
    }
}
