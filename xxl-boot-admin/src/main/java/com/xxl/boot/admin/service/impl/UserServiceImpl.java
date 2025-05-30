package com.xxl.boot.admin.service.impl;

import com.xxl.boot.admin.mapper.RoleMapper;
import com.xxl.boot.admin.mapper.UserMapper;
import com.xxl.boot.admin.mapper.UserRoleMapper;
import com.xxl.boot.admin.model.adaptor.XxlBootUserAdaptor;
import com.xxl.boot.admin.model.dto.LoginUserDTO;
import com.xxl.boot.admin.model.dto.XxlBootUserDTO;
import com.xxl.boot.admin.model.entity.XxlBootRole;
import com.xxl.boot.admin.model.entity.XxlBootUser;
import com.xxl.boot.admin.model.entity.XxlBootUserRole;
import com.xxl.boot.admin.service.UserService;
import com.xxl.boot.admin.util.I18nUtil;
import com.xxl.tool.core.CollectionTool;
import com.xxl.tool.core.StringTool;
import com.xxl.tool.response.PageModel;
import com.xxl.tool.response.Response;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * user service
 *
 * @author xuxueli
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;
    @Resource
    private RoleMapper roleMapper;
    @Resource
    private UserRoleMapper userRoleMapper;

    /**
     * 新增
     */
    @Override
    public Response<String> insert(XxlBootUserDTO xxlJobUser) {

        // adapt
        XxlBootUser user = XxlBootUserAdaptor.adapt(xxlJobUser);
        List<Integer> roleIds = xxlJobUser.getRoleIds();


        // valid empty
        if (user == null) {
            return Response.ofFail(I18nUtil.getString("system_param_empty"));
        }
        // valid username
        if (StringTool.isBlank(user.getUsername())) {
            return Response.ofFail(I18nUtil.getString("system_please_input") + I18nUtil.getString("user_username"));
        }
        user.setUsername(user.getUsername().trim());
        if (!(user.getUsername().length()>=4 && user.getUsername().length()<=20)) {
            return Response.ofFail(I18nUtil.getString("system_lengh_limit")+"[4-20]");
        }
        // valid password
        if (StringTool.isBlank(user.getPassword())) {
            return Response.ofFail( I18nUtil.getString("system_please_input")+I18nUtil.getString("user_password") );
        }
        user.setPassword(user.getPassword().trim());
        if (!(user.getPassword().length()>=4 && user.getPassword().length()<=20)) {
            return Response.ofFail( I18nUtil.getString("system_lengh_limit")+"[4-20]" );
        }
        // md5 password
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));    // todo，move to token

        // valid user role
        if (CollectionTool.isNotEmpty(roleIds)) {
            List<XxlBootRole> roles = roleMapper.queryByRoleIds(roleIds);
            if (!(roles!=null && roles.size()==roleIds.size())) {
                return Response.ofFail("操作失败，角色ID非法");
            }
        }

        // check repeat
        XxlBootUser existUser = userMapper.loadByUserName(user.getUsername());
        if (existUser != null) {
            return Response.ofFail( I18nUtil.getString("user_username_repeat") );
        }

        // save user
        userMapper.insert(user);

        // save user-role
        if (CollectionTool.isNotEmpty(roleIds)) {
            List<XxlBootUserRole> userRoleList = roleIds
                    .stream()
                    .map(roleId-> new XxlBootUserRole(user.getId(), roleId))
                    .collect(Collectors.toList());
            userRoleMapper.batchInsert(userRoleList);
        }

        return Response.ofSuccess();
    }

    /**
     * 删除
     */
    @Override
    public Response<String> delete(int id) {
        int ret = userMapper.delete(id);
        return ret>0? Response.ofSuccess() : Response.ofFail();
    }

    /**
     * 删除
     */
    @Override
    public Response<String> deleteByIds(List<Integer> userIds, LoginUserDTO loginUser) {

        // valid
        if (CollectionTool.isEmpty(userIds)) {
            return Response.ofFail(I18nUtil.getString("system_please_choose") + I18nUtil.getString("user_tips"));
        }

        // avoid opt login seft
        if (userIds.contains(loginUser.getId())) {
            return Response.ofFail( I18nUtil.getString("user_update_loginuser_limit") );
        }

        // valid user role
        List<XxlBootUserRole> userRoleList = userRoleMapper.queryByUserIds(userIds);
        if (CollectionTool.isNotEmpty(userRoleList)) {
            return Response.ofFail("无法删除，请先取消关联角色");
        }


        int ret = userMapper.deleteByIds(userIds);
        return ret>0? Response.ofSuccess() : Response.ofFail();
    }

    /**
     * 更新
     */
    @Override
    public Response<String> update(XxlBootUserDTO xxlJobUser, LoginUserDTO loginUser) {

        // adapt
        XxlBootUser user = XxlBootUserAdaptor.adapt(xxlJobUser);
        List<Integer> roleIds = xxlJobUser.getRoleIds();

        // avoid opt login seft
        if (loginUser.getUsername().equals(user.getUsername())) {
            return Response.ofFail( I18nUtil.getString("user_update_loginuser_limit") );
        }

        // valid password
        if (StringTool.isNotBlank(user.getPassword())) {
            user.setPassword(user.getPassword().trim());
            if (!(user.getPassword().length()>=4 && user.getPassword().length()<=20)) {
                return Response.ofFail(  I18nUtil.getString("system_lengh_limit")+"[4-20]" );
            }
            // md5 password
            user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        } else {
            user.setPassword(null);
        }

        // valid user role
        if (CollectionTool.isNotEmpty(roleIds)) {
            List<XxlBootRole> roles = roleMapper.queryByRoleIds(roleIds);
            if (!(roles!=null && roles.size()==roleIds.size())) {
                return Response.ofFail("操作失败，角色ID非法");
            }
        }

        // update user
        int ret = userMapper.update(user);

        // update user-role
        userRoleMapper.deleteByUserId(user.getId());
        if (CollectionTool.isNotEmpty(roleIds)) {
            List<XxlBootUserRole> userRoleList = roleIds
                    .stream()
                    .map(roleId-> new XxlBootUserRole(user.getId(), roleId))
                    .collect(Collectors.toList());
            userRoleMapper.batchInsert(userRoleList);
        }

        return ret>0? Response.ofSuccess() : Response.ofFail();
    }

    /**
     * 修改密码
     */
    public Response<String> updatePwd(LoginUserDTO loginUser, String password){
        // valid password
        if (StringTool.isBlank(password)){
            Response.ofFail( "密码不可为空" );
        }
        password = password.trim();
        if (!(password.length()>=4 && password.length()<=20)) {
            Response.ofFail( I18nUtil.getString("system_lengh_limit")+"[4-20]" );
        }

        // md5 password
        String md5Password = DigestUtils.md5DigestAsHex(password.getBytes());

        // update pwd
        XxlBootUser existUser = userMapper.loadByUserName(loginUser.getUsername());
        existUser.setPassword(md5Password);
        userMapper.update(existUser);

        return Response.ofSuccess();
    }

    /**
     * Load查询
     */
    @Override
    public Response<XxlBootUser> loadByUserName(String username){
        XxlBootUser record = userMapper.loadByUserName(username);
        return Response.ofSuccess(record);
    }

    /**
     * 分页查询
     */
    @Override
    public PageModel<XxlBootUserDTO> pageList(int offset, int pagesize, String username, int status) {

        // data
        List<XxlBootUser> pageList = userMapper.pageList(offset, pagesize, username, status);
        int totalCount = userMapper.pageListCount(offset, pagesize, username, status);

        // adaptor
        List<XxlBootUserDTO> pageListDto = new ArrayList<>();
        if (CollectionTool.isNotEmpty(pageList)) {
            // find role
            List<Integer> userIds = pageList.stream().map(XxlBootUser::getId).collect(Collectors.toList());
            List<XxlBootUserRole> userRoleList = userRoleMapper.queryByUserIds(userIds);

            // user-roleids map
            Map<Integer, List<Integer>> userIdToRoleIdsMap = Optional
                    .ofNullable(userRoleList)
                    .orElse(new ArrayList<>()).stream()
                    .collect(Collectors.groupingBy(
                            XxlBootUserRole::getUserId,
                            Collectors.mapping(XxlBootUserRole::getRoleId, Collectors.toList())
                    ));

            // dto list
            pageListDto = pageList
                    .stream()
                    .map(item->XxlBootUserAdaptor.adapt2dto(item, false, userIdToRoleIdsMap))
                    .collect(Collectors.toList());
        }

        // result
        PageModel<XxlBootUserDTO> pageModel = new PageModel<XxlBootUserDTO>();
        pageModel.setPageData(pageListDto);
        pageModel.setTotalCount(totalCount);

        return pageModel;
    }

}
