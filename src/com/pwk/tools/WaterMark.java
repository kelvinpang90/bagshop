package com.pwk.tools;


import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import org.apache.commons.lang3.StringUtils;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by wenkai.peng on 1/26/2015.
 */
public class WaterMark {

    private static final int OFFSET_X = 10;
    private static final int OFFSET_Y = 10;

    public static final int MARK_LEFT_TOP = 1;
    public static final int MARK_RIGHT_TOP = 2;
    public static final int MARK_CENTER = 3;
    public static final int MARK_LEFT_BOTTOM = 4;
    public static final int MARK_RIGHT_BOTTOM = 5;

    public static void markImage(File srcImg, File markImg, float alpha, int mark_position) {
        if(!srcImg.exists()||!markImg.exists())
            return;
        try {
            Image src = ImageIO.read(srcImg);

            int width = src.getWidth(null);
            int height = src.getHeight(null);
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.drawImage(src, 0, 0, width, height, null);

            Image mark_img = ImageIO.read(markImg);
            int mark_img_width = mark_img.getWidth(null);
            int mark_img_height = mark_img.getHeight(null);

            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));

            switch (mark_position) {
                case WaterMark.MARK_LEFT_TOP:
                    g.drawImage(mark_img, OFFSET_X, OFFSET_Y, mark_img_width, mark_img_height, null);
                    break;
                case WaterMark.MARK_LEFT_BOTTOM:
                    g.drawImage(mark_img, OFFSET_X, (height - mark_img_height - OFFSET_Y), mark_img_width, mark_img_height, null);
                    break;
                case WaterMark.MARK_CENTER:
                    g.drawImage(mark_img, (width - mark_img_width - OFFSET_X) / 2, (height - mark_img_height - OFFSET_Y) / 2,mark_img_width, mark_img_height, null);
                    break;
                case WaterMark.MARK_RIGHT_TOP:
                    g.drawImage(mark_img, (width - mark_img_width - OFFSET_X), OFFSET_Y, mark_img_width, mark_img_height, null);
                    break;
                case WaterMark.MARK_RIGHT_BOTTOM:
                default:g.drawImage(mark_img, (width - mark_img_width - OFFSET_X), (height - mark_img_height - OFFSET_Y),mark_img_width, mark_img_height, null);
            }
            g.dispose();
            FileOutputStream out = new FileOutputStream(srcImg);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(image);
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static void markText(File srcImg,String text,int offset_x, int offset_y){
        if(!srcImg.exists()|| StringUtils.isBlank(text))
            return;
        try {
            Image src = ImageIO.read(srcImg);
            int width = src.getWidth(null);
            int height = src.getHeight(null);
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

            Graphics g = image.createGraphics();
            g.drawImage(src, 0, 0, width, height, null);

            g.drawString(text,  offset_x, height  / 2 - offset_y);
            g.dispose();

            FileOutputStream out = new FileOutputStream(srcImg);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(image);
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
