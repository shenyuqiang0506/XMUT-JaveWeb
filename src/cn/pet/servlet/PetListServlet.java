package cn.pet.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import cn.pet.dao.PetDao;
import cn.pet.entity.Pet;

@WebServlet("/petList")
public class PetListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PetDao dao = new PetDao();

        // 定义每页显示多少条
        int pageSize = 8;

        // 接收当前页码
        String pageStr = request.getParameter("page");
        int currPage = 1;
        if (pageStr != null && !pageStr.equals("")) {
            currPage = Integer.parseInt(pageStr);
        }

        // 查询总记录数，计算总页数
        int totalCount = dao.getPetCount();
        // 总页数 = (总数 + 每页数 - 1) / 每页数
        int totalPage = (totalCount + pageSize - 1) / pageSize;

        if (currPage < 1) currPage = 1;
        if (currPage > totalPage && totalPage > 0) currPage = totalPage;

        // 查询当前页的数据
        List<Pet> list = dao.getPetListByPage(currPage, pageSize);

        //将所有数据存入 request
        request.setAttribute("list", list);
        request.setAttribute("currPage", currPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalCount", totalCount);

        //转发
        request.getRequestDispatcher("pet_list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}