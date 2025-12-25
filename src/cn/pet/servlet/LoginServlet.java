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

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // --- 1. 验证码校验逻辑---
        String userCaptcha = request.getParameter("captcha");
        HttpSession session = request.getSession();
        String trueCaptcha = (String) session.getAttribute("CHECK_CODE_KEY");

        // 移除 Session 中的验证码
        session.removeAttribute("CHECK_CODE_KEY");

        if (trueCaptcha == null || !trueCaptcha.equalsIgnoreCase(userCaptcha)) {
            request.setAttribute("msg", "❌ 验证码错误或已过期");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        // 2. 原有的登录逻辑
        String uName = request.getParameter("username");
        String pWord = request.getParameter("password");

        UserDao userDao = new UserDao();
        User user = userDao.login(uName, pWord);

        if (user != null) {
            session.setAttribute("currUser", user);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("msg", "❌ 用户名或密码错误");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}