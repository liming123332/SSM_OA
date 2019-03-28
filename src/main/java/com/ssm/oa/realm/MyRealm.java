package com.ssm.oa.realm;

import com.ssm.oa.entity.SysUser;
import com.ssm.oa.service.ISysUserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm {

    @Autowired
    private ISysUserService sysUserService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token= (UsernamePasswordToken) authenticationToken;
        String username = token.getUsername();
        SysUser sysUser=sysUserService.getUserByName(username);
        if(sysUser!=null){
            //盐值
            ByteSource byteSource=ByteSource.Util.bytes(username);
            SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(sysUser, sysUser.getUserPassword(),byteSource,this.getName());
            return info;
        }
        return null;
    }
}
