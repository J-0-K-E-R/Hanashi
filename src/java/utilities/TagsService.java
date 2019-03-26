/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilities;

import java.util.ArrayList;

/**
 *
 * @author robogod
 */
public class TagsService {
    public static ArrayList<String> tagsToArrayList(String tagsString) {
        String[] tags;
        ArrayList<String> returnTags = new ArrayList();
        String i;
        
        tags = tagsString.trim().split(";");
        for(String z: tags) {
            i = z.trim();
            if(!i.equals(""))
                returnTags.add(i);
        }
        
        return returnTags;
    }
}
