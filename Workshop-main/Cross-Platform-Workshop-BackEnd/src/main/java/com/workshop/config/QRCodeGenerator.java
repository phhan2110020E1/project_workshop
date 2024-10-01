package com.workshop.config;
import java.awt.image.BufferedImage;

import com.google.gson.Gson;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.workshop.config.cloud.ObjContent;
import org.springframework.stereotype.Component;

@Component
public class QRCodeGenerator {
    public  BufferedImage generateQRCodeImage(ObjContent Content, int width, int height) {
        try {
            Gson gson = new Gson();
            String contentString = gson.toJson(Content);
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(contentString, BarcodeFormat.QR_CODE, width, height);
            return MatrixToImageWriter.toBufferedImage(bitMatrix);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
