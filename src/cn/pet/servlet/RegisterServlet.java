package cn.pet.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import cn.pet.dao.UserDao;
import cn.pet.entity.User;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 1. 获取参数
        String uName = request.getParameter("username");
        String pWord = request.getParameter("password");
        String rName = request.getParameter("realName");
        String phone = request.getParameter("phone");
        
        UserDao userDao = new UserDao();
        
        // 2. 检查用户名是否重复
        if (userDao.isUsernameExist(uName)) {
            request.setAttribute("msg", "该用户名已被使用，请更换！");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        // 3. 封装并保存
        User user = new User(uName, pWord, rName, phone, 0); // 0代表普通用户
        boolean success = userDao.register(user);
        
        if (success) {
            // 注册成功，跳到登录页，并提示
            request.setAttribute("msg", "注册成功，请登录！");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "注册失败，系统异常。");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}