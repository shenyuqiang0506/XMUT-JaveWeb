package cn.pet.servlet;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import cn.pet.dao.PetDao;
import cn.pet.entity.Pet;
import cn.pet.entity.User;

@WebServlet("/publishServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class PublishServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        // 1. 权限验证
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. 获取普通文本字段
        String petName = request.getParameter("petName");
        String type = request.getParameter("type");
        String sex = request.getParameter("sex");
        String age = request.getParameter("age");
        String desc = request.getParameter("description");

        // 3. 处理文件上传
        String fileName = "default.jpg";
        Part part = request.getPart("petImage");

        // 用户上传了文件
        if (part != null && part.getSize() > 0) {
            // 获取原始文件名
            String submittedFileName = part.getSubmittedFileName();

            // 获取后缀名
            String ext = submittedFileName.substring(submittedFileName.lastIndexOf("."));

            // 生成唯一的新文件名
            fileName = UUID.randomUUID().toString() + ext;

            // 获取服务器存放图片的绝对路径
            String savePath = request.getServletContext().getRealPath("/static/images");

            // 如果目录不存在，则创建
            File fileDir = new File(savePath);
            if (!fileDir.exists()) {
                fileDir.mkdirs();
            }

            // 将文件写入磁盘
            part.write(savePath + File.separator + fileName);
        }

        // 4. 封装对象
        Pet pet = new Pet();
        pet.setPetName(petName);
        pet.setType(type);
        pet.setSex(sex);
        pet.setAge(age);
        pet.setDescription(desc);
        pet.setImage(fileName);
        pet.setPublisherId(user.getId());
        pet.setStatus(0); // 默认为待审核

        // 5. 调用DAO保存
        PetDao petDao = new PetDao();
        boolean success = petDao.addPet(pet);

        if (success) {
            response.sendRedirect("publish_success.jsp");
        } else {
            response.getWriter().write("发布失败，请重试");
        }
    }
}