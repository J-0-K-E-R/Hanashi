/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.nashorn.internal.objects.NativeDebug;

/**
 *
 * @author robogod
 */
public class Configurations {
    private static String filePath = "config.properties";
    
    public static String getArticleImagesPath() {
        String path = "";
                
        
        File configFile = new File(filePath);
 
        try {
            FileReader reader = new FileReader(configFile);
            Properties props = new Properties();
            props.load(reader);

            path = props.getProperty("articleImagesPath");

            reader.close();
        } catch (FileNotFoundException e) {
            // file does not exist
            Logger.getLogger(Configurations.class.getName()).log(Level.SEVERE, null, e);
        } catch (IOException e) {
            // I/O error
            Logger.getLogger(Configurations.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return path;
    }
    
    public static void setArticleImagesPath(String path) {
        File configFile = new File(filePath);
 
        try {
            Properties props = new Properties();
            props.setProperty("articleImagesPath", path);
            FileWriter writer = new FileWriter(configFile);
            props.store(writer, "path settings");
            writer.close();
        } catch (FileNotFoundException ex) {
            // file does not exist
        } catch (IOException ex) {
            // I/O error
        }
    }
}
