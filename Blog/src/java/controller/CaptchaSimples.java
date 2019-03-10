/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;
import java.awt.Color;
import java.awt.Font;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.renderer.DefaultWordRenderer;

/**
 *
 * @author mathe
 */
@WebServlet("/gerador-captcha")
public class CaptchaSimples extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Color> cores = new ArrayList<Color> ();
        cores.add(Color.blue);
        cores.add(Color.red);
         
        List<Font> fontes = new ArrayList<Font>();
        fontes.add(new Font("Arial", Font.ITALIC, 24));
         
        Captcha captcha = new Captcha.Builder(93, 39)
                .addText(new DefaultWordRenderer(cores, fontes))
                .addBackground(new GradiatedBackgroundProducer(Color.gray, Color.white))
                .gimp()
                .addNoise()
                .addBorder()
                .build();
        
        CaptchaServletUtil.writeImage(response, captcha.getImage());
        request.getSession().setAttribute("captchaValido", captcha.getAnswer());
    }
}
