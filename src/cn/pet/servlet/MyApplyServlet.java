package cn.pet.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import cn.pet.dao.ApplyDao;
import cn.pet.entity.Apply;
import cn.pet.entity.User;

@WebServlet("/myApplyServlet")
public class MyApplyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currUser = (User) session.getAttribute("currUser");
        
        if (currUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // 查询该用户的所有申请
        ApplyDao applyDao = new ApplyDao();
        List<Apply> myApplies = applyDao.findAppliesByUserId(currUser.getId());
        
        request.setAttribute("applyList", myApplies);
        request.getRequestDispatcher("my_apply.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}