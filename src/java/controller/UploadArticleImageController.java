/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.google.gson.reflect.TypeToken;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.FileOutputStream;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Part;

/**
 *
 * @author robogod
 */
@MultipartConfig
public class UploadArticleImageController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Log ::::: Uploading Image");
        utilities.Configurations config = new utilities.Configurations();
        String fileRoute = config.getArticleImagesPath();

        Map<Object, Object> responseData = new HashMap<>();
        try {
//          System.out.println("Log ::::: Test URL : " + request.getServletContext().getRealPath("/images/"));
            System.out.println("Log :::: Path is " + fileRoute);
            
            Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
            InputStream fileContent = filePart.getInputStream();
            
            byte[] buffer = new byte[fileContent.available()];
            fileContent.read(buffer);
            fileContent.close();
            
            File imgFile = new File(fileRoute+fileName);
            OutputStream outputStream = new FileOutputStream(imgFile);
            outputStream.write(buffer);
            
            outputStream.close();
            
            String imgurResponse = utilities.Imgur.getImgurContent("02f4ec639f412f8", imgFile);
            Gson gson = new Gson();
            HashMap<String, Object> map = gson.fromJson(imgurResponse, HashMap.class);
            LinkedTreeMap<String, Object> treeMap = (LinkedTreeMap)map.get("data");
            
            
            responseData.put("link", treeMap.get("link"));
            
        } catch (Exception e) { 
            Logger.getLogger(UploadArticleImageController.class.getName()).log(Level.SEVERE, null, e);
            
            responseData = new HashMap<>();
            responseData.put("error", e.toString());
        }
        String jsonResponseData = new Gson().toJson(responseData);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponseData);
        
        System.out.println("Log ::::: Image Uploaded : " + jsonResponseData);
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
