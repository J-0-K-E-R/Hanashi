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

/**
 *
 * @author robogod
 */
public class Configurations {
    private String filePath = "config.properties";
    private File configFile;

    public Configurations() {
        try {
            configFile = new File(filePath);
            if(!configFile.exists()) {
                configFile.createNewFile();
                this.setArticleImagesPath("./");
            }
        } catch(Exception e) {
            Logger.getLogger(Configurations.class.getName()).log(Level.SEVERE,null, e);
        }
    }
    
    final public String getArticleImagesPath() {
        String path = "";
                
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
    
    final public void setArticleImagesPath(String path) {
 
        try {
            Properties props = new Properties();
            props.setProperty("articleImagesPath", path);
            FileWriter writer = new FileWriter(configFile);
            props.store(writer, "path settings");
            writer.close();
        } catch (FileNotFoundException e) {
            Logger.getLogger(Configurations.class.getName()).log(Level.SEVERE,null, e);
        } catch (IOException e) {
            Logger.getLogger(Configurations.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
