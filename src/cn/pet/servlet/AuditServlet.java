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
import cn.pet.dao.PetDao;
import cn.pet.entity.Apply;
import cn.pet.entity.Pet;
import cn.pet.entity.User;

@WebServlet("/auditServlet")
public class AuditServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置请求编码
        request.setCharacterEncoding("UTF-8");
        // 2. 设置响应编码
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currUser");

        if (user == null || user.getRole() != 1) {
            response.getWriter().write("无权访问");
            return;
        }

        String action = request.getParameter("action");
        PetDao petDao = new PetDao();
        ApplyDao applyDao = new ApplyDao();

        // 处理领养申请审核
        switch (action) {
            case "audit" -> {
                int applyId = Integer.parseInt(request.getParameter("applyId"));
                int petId = Integer.parseInt(request.getParameter("petId"));
                int status = Integer.parseInt(request.getParameter("status"));
                applyDao.auditApply(applyId, petId, status);
                response.sendRedirect("auditServlet");

            }
            case "auditPet" -> {
                int petId = Integer.parseInt(request.getParameter("petId"));
                int result = Integer.parseInt(request.getParameter("result"));
                petDao.auditPet(petId, result == 1);
                response.sendRedirect("auditServlet");
            }

            // 批量审核
            case "batchAuditPet" -> {
                String[] ids = request.getParameterValues("ids");
                int result = Integer.parseInt(request.getParameter("result"));
                if (ids != null && ids.length > 0) {
                    for (String idStr : ids) {
                        try {
                            int petId = Integer.parseInt(idStr);
                            petDao.auditPet(petId, result == 1);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
                response.sendRedirect("auditServlet");
            }

            //列表展示
            case null, default -> {
                List<Apply> applyList = applyDao.findAllApplies();
                request.setAttribute("applyList", applyList);

                List<Pet> pendingPets = petDao.findPendingPets();
                request.setAttribute("pendingPets", pendingPets);

                request.getRequestDispatcher("admin/audit_list.jsp").forward(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}