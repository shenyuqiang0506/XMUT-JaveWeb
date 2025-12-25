package cn.pet.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;


@WebListener
public class OnlineUserListener implements HttpSessionListener, HttpSessionAttributeListener {

    //监听属性添加
    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        if ("is_human".equals(event.getName())) {
            updateCount(event.getSession().getServletContext(), 1);
            System.out.println("✅ 有效用户上线 (Session标记成功)");
        }
    }

    // 监听 Session 销毁
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        if (se.getSession().getAttribute("is_human") != null) {
            updateCount(se.getSession().getServletContext(), -1);
            System.out.println("❌ 有效用户下线");
        }
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {

    }

    // 更新人数
    private void updateCount(ServletContext application, int num) {
        Integer count = (Integer) application.getAttribute("onlineCount");
        if (count == null) count = 0;
        count += num;
        application.setAttribute("onlineCount", count);
    }
}