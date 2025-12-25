package cn.pet.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

/**
 * 敏感词过滤器：拦截所有请求，将敏感词替换为 ***
 */
@WebFilter("/*") // 拦截所有路径
public class SensitiveWordFilter implements Filter {

    // 1. 定义敏感词库
    private List<String> banList = new ArrayList<>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化敏感词
        banList.add("笨蛋");
        banList.add("暴力");
        banList.add("混蛋");
        banList.add("非法");
        banList.add("垃圾");
        System.out.println("✅ 敏感词过滤器已启动...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        MyRequestWrapper myRequest = new MyRequestWrapper(req);
        chain.doFilter(myRequest, response);
    }

    @Override
    public void destroy() {}
    class MyRequestWrapper extends HttpServletRequestWrapper {
        public MyRequestWrapper(HttpServletRequest request) {
            super(request);
        }

        // 重写获取参数的方法
        @Override
        public String getParameter(String name) {
            // 1. 获取原始值
            String value = super.getParameter(name);
            if (value != null) {
                // 2. 遍历敏感词库进行替换
                for (String word : banList) {
                    if (value.contains(word)) {
                        String stars = "*".repeat(word.length());
                        value = value.replace(word, stars);
                    }
                }
            }
            return value;
        }
    }
}