/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 *
 * @author robogod
 */
public class ThreadsService {
    
    public static String encodeTitleToURL(String url) {
        try {
            
            String encodeURL=URLEncoder.encode( url, "UTF-8" );
            
            return encodeURL;
            
        } catch (UnsupportedEncodingException e) {
            
            return "Issue while encoding" +e.getMessage();
            
        }  
    }
    
    public static String decodeURLToTitle(String url)       
    {
        try {
            String prevURL="";
            String decodeURL=url;
            while(!prevURL.equals(decodeURL))   
            {
                prevURL=decodeURL;
                decodeURL=URLDecoder.decode( decodeURL, "UTF-8" );
            }
            return decodeURL;
        } catch (UnsupportedEncodingException e) {
            return "Issue while decoding" +e.getMessage();   
        }
    }
}
