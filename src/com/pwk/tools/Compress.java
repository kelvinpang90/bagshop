package com.pwk.tools;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import org.apache.commons.lang.StringUtils;

import javax.imageio.*;
import javax.imageio.plugins.jpeg.JPEGImageWriteParam;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-1-22
 * Time: 下午8:19
 * To change this template use File | Settings | File Templates.
 */
public class Compress {
    public static boolean compress(File srcPath, float quality) {
        File file = null;
        BufferedImage src = null;
        FileOutputStream out = null;
        try {
            ImageWriter imageWriter;
            ImageWriteParam imageWriteParam;

            imageWriter = ImageIO.getImageWritersByFormatName("jpg").next();
            imageWriteParam = new JPEGImageWriteParam(null);

            imageWriteParam.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
            imageWriteParam.setCompressionQuality(quality);
            imageWriteParam.setProgressiveMode(ImageWriteParam.MODE_DISABLED);

            ColorModel colorModel = ColorModel.getRGBdefault();

            imageWriteParam.setDestinationType(new ImageTypeSpecifier(colorModel, colorModel.createCompatibleSampleModel(32, 32)));

            if (srcPath!=null) {
                src = ImageIO.read(srcPath);
                File destPath = new File(srcPath.getParent(),srcPath.getName().split("\\.")[0]+"(min)."+StringTools.getFileType(srcPath.getName()));
                out = new FileOutputStream(destPath);

                imageWriter.reset();
                imageWriter.setOutput(ImageIO.createImageOutputStream(out));

                imageWriter.write(null, new IIOImage(src, null, null), imageWriteParam);
                System.out.println("图片压缩成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("图片压缩失败！");
            return false;
        } finally {
            try {
                out.flush();
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return true;
    }
    private static String getFileType(String file) {
        if (StringUtils.isNotBlank(file)) {
            int dot = file.lastIndexOf('.');
            if ((dot > -1) && (dot < (file.length() - 1))) {
                return file.substring(dot + 1);
            }
        }
        return null;
    }

    public static String  compressPics(File srcFile,float quality){
        try {
            String destPath =  srcFile.getParent()+"/mini/";
            if(!srcFile.exists()){
                return null;
            }
            File destFile = new File(destPath);
            if(!destFile.exists()){
                destFile.mkdirs();
            }
            Image image = ImageIO.read(srcFile);
            // 判断图片格式是否正确
            if(image.getWidth(null)==-1){
                System.out.println("非图片格式无法压缩!");
                return null;
            }
            int newWidth = (int) (((double) image.getWidth(null)) / quality);
            int newHeight = (int) (((double) image.getHeight(null)) / quality);

            BufferedImage tag = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
            tag.getGraphics().drawImage(image.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH), 0, 0, null);

            File compressFile = new File(destFile,srcFile.getName());
            FileOutputStream out = new FileOutputStream(compressFile);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(tag);
            out.close();
            return compressFile.getPath();
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
