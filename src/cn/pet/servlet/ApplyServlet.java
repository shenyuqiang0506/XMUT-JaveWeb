package cn.pet.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import cn.pet.dao.ApplyDao;
import cn.pet.entity.Apply;
import cn.pet.entity.User;

@WebServlet("/applyServlet")
public class ApplyServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置编码
        request.setCharacterEncoding("UTF-8");
        
        // 2. 权限验证：确保用户已登录
        HttpSession session = request.getSession();
        User currUser = (User) session.getAttribute("currUser");
        
        if (currUser == null) {
            // 没登录，去登录页
            response.sendRedirect("login.jsp");
            return;
        }
        
        // 3. 获取表单数据
        String petIdStr = request.getParameter("petId");
        String reason = request.getParameter("reason");
        
        if (petIdStr != null && !petIdStr.isEmpty()) {
            int petId = Integer.parseInt(petIdStr);
            
            // 4. 封装对象并保存
            Apply apply = new Apply(currUser.getId(), petId, reason);
            ApplyDao applyDao = new ApplyDao();
            boolean success = applyDao.saveApply(apply);
            
            if (success) {
                // 5. 成功，跳转到“我的申请记录”页面
                response.sendRedirect("myApplyServlet"); 
            } else {
                // 失败处理
                response.getWriter().write("申请提交失败，请稍后重试。");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}