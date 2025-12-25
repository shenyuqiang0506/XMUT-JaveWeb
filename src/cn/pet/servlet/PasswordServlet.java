package cn.pet.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import cn.pet.dao.UserDao;
import cn.pet.entity.User;

@WebServlet("/passwordServlet")
public class PasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 验证登录
        HttpSession session = request.getSession();
        User currUser = (User) session.getAttribute("currUser");
        if (currUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPwd = request.getParameter("oldPassword");
        String newPwd = request.getParameter("newPassword");
        String confirmPwd = request.getParameter("confirmPassword");

        // 2. 校验两次新密码是否一致
        if (!newPwd.equals(confirmPwd)) {
            request.setAttribute("msg", "两次输入的新密码不一致！");
            request.getRequestDispatcher("password.jsp").forward(request, response);
            return;
        }

        // 3. 校验旧密码
        if (!currUser.getPassword().equals(oldPwd)) {
            request.setAttribute("msg", "旧密码错误！");
            request.getRequestDispatcher("password.jsp").forward(request, response);
            return;
        }

        // 4. 执行更新
        UserDao userDao = new UserDao();
        boolean success = userDao.updatePassword(currUser.getId(), newPwd);

        if (success) {
            // 更新 Session 中的密码，避免下次修改报错
            currUser.setPassword(newPwd);
            request.setAttribute("successMsg", "密码修改成功！");
            request.getRequestDispatcher("password.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "系统繁忙，修改失败");
            request.getRequestDispatcher("password.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}