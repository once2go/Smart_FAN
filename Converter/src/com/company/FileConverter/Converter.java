package com.company.FileConverter;

import java.io.*;
import java.util.List;
import java.util.Scanner;

/**
 * Created by once2go on 04.07.16.
 */
public class Converter {

    private static final String DIR_NAME = "outputs";
    private static final String OUT_EXTENSION = ".usw";

    private static void buildOutput(String fileName, String outputs) throws IOException {
        new File(DIR_NAME).mkdir();
        File file = new File("outputs/" + fileName + OUT_EXTENSION);
        FileWriter fw = new FileWriter(file.getAbsoluteFile());
        BufferedWriter bw = new BufferedWriter(fw);
        bw.write(outputs);
        bw.close();
    }


    public static void convert() {
        List<String> list = FileScanner.getScripts();
        StringBuilder globalBuilder = new StringBuilder();
        for (String name : list) {
            StringBuilder builder = new StringBuilder();
            Scanner scan = null;
            try {
                scan = new Scanner(new File(name));
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            if (scan == null) return;
            addHeader(builder, name);
            addHeader(globalBuilder, name);
            while (scan.hasNextLine()) {
                String line = scan.nextLine().trim();
                if (!line.isEmpty()) {
                    builder.append("file.writeline([[" + line + "]])\n");
                    globalBuilder.append("file.writeline([[" + line + "]])\n");
                }
            }
            addFooter(builder);
            addFooter(globalBuilder);
            try {
                buildOutput(name.substring(0, name.length() - 4), builder.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            buildOutput("firmware", globalBuilder.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static StringBuilder addHeader(StringBuilder builder, String filename) {
        builder.append("file.open(\"" + filename + "\",\"w+\")\n");
        return builder;
    }

    private static StringBuilder addFooter(StringBuilder builder) {
        builder.append("file.flush()\n");
        builder.append("file.close()\n");
        builder.append("\n");
        return builder;
    }
}
