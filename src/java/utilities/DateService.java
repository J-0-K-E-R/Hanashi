/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.util.Calendar;
import java.text.SimpleDateFormat;

/**
 *
 * @author robogod
 */
public class DateService {
    
    public static String relativeDate(Calendar date) {
        String ret = "";
        Calendar currentDate = Calendar.getInstance();
        
        long milliDiff = currentDate.getTimeInMillis() - date.getTimeInMillis();
        long seconds = milliDiff/1000;
        long minutes = seconds/60;
        long hours = minutes/60;
        long days = hours/24;
        long months = days/30;
        long years = days/365;
        
        if(years == 0 && months == 0 && days == 0 && hours == 0 && minutes == 0) 
            ret = "A few seconds ago";
        else if(years == 0 && months == 0 && days == 0 && hours == 0 ) 
            if(minutes == 1)
                ret = "A minute ago";
            else
                ret = minutes+" minutes ago";
        else if(years == 0 && months == 0 && days == 0)
            if(hours == 1)
                ret = "An hour ago";
            else
                ret = hours + " hours ago";
        else if(years == 0 && months == 0)
            if(days == 1)
                ret = "A day ago";
            else
                ret = days + " days ago";
        else if(years == 0)
            if(months == 1)
                ret = "A month ago";
            else
                ret = months + " months ago";
        else {
            SimpleDateFormat sdf = new SimpleDateFormat("MMM YYYY");
            try {
                ret = sdf.format(date.getTime());
            } 
            catch(Exception e) {
                System.out.println(e.getClass()+ " : " +e.getMessage());
            }
        }    
        return ret;
    }
    
}
