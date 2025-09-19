package com.xxl.boot.admin.web.interceptor;

import com.xxl.boot.admin.service.ResourceService;
import com.xxl.boot.admin.util.I18nUtil;
import com.xxl.tool.freemarker.FtlTool;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.AsyncHandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * web mvc config
 *
 * @author xuxueli 2018-04-02 20:48:20
 */
@Configuration
public class CommonDataInterceptor implements WebMvcConfigurer {

    @Resource
    private ResourceService resourceService;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AsyncHandlerInterceptor() {
            @Override
            public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
                if (modelAndView != null) {
                    // i18n, static method
                    modelAndView.addObject("I18nUtil", FtlTool.generateStaticModel(I18nUtil.class.getName()));
                }
            }
        }).addPathPatterns("/**");
    }

}