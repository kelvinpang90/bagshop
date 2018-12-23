package com.pwk.tools;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by wenkai.peng on 1/19/2015.
 */
public class TimerTool {

    private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static void setTimer(String dateStr){
        try {
            Date date = format.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
