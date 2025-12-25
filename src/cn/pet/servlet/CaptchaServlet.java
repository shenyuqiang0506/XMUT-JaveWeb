package cn.pet.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;
import javax.imageio.ImageIO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/captchaServlet")
public class CaptchaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int width = 100;
        int height = 40;
        
        // 1. 创建内存中的图片
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        
        // 2. 画背景
        g.setColor(new Color(240, 240, 240));
        g.fillRect(0, 0, width, height);
        
        // 3. 画干扰线
        Random r = new Random();
        for (int i = 0; i < 20; i++) {
            g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255)));
            g.drawLine(r.nextInt(width), r.nextInt(height), r.nextInt(width), r.nextInt(height));
        }
        
        // 4. 生成随机字符并画在图上
        String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
        StringBuilder sb = new StringBuilder();
        g.setFont(new Font("Arial", Font.BOLD, 24));
        
        for (int i = 0; i < 4; i++) {
            int index = r.nextInt(str.length());
            char ch = str.charAt(index);
            sb.append(ch);
            g.setColor(new Color(r.nextInt(150), r.nextInt(150), r.nextInt(150)));
            g.drawString(String.valueOf(ch), 20 * i + 10, 28);
        }
        
        // 5.将验证码存入 Session
        request.getSession().setAttribute("CHECK_CODE_KEY", sb.toString());
        
        // 6. 输出图片到页面
        ImageIO.write(image, "jpg", response.getOutputStream());
    }
}