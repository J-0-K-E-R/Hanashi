/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pojos;

/**
 *
 * @author robogod
 */
public class Points {

    private static final int threadUpvote = 2;
    private static final int threadDownvote = 1;
    private static final int postUpvote = 5;
    private static final int postDownvote = 1;
    private static final int selfDownvote = 1;
    
    
    /**
     * @return the threadUpvote
     */
    public static int getThreadUpvote() {
        return threadUpvote;
    }

    /**
     * @return the threadDownvote
     */
    public static int getThreadDownvote() {
        return threadDownvote;
    }

    /**
     * @return the postUpvote
     */
    public static int getPostUpvote() {
        return postUpvote;
    }

    /**
     * @return the postDownvote
     */
    public static int getPostDownvote() {
        return postDownvote;
    }

    /**
     * @return the selfDownvote
     */
    public static int getSelfDownvote() {
        return selfDownvote;
    }
}
