package com.company.FileConverter;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by once2go on 04.07.16.
 */
public class FileScanner {

    public static List<String> getScripts() {
        List<String> list = new ArrayList<>();
        File curDir = new File(".");
        File[] filesList = curDir.listFiles();
        for (File f : filesList) {
            if (f.isFile()) {
                String name = f.getName();
                if (name.substring(name.length() - 4, name.length()).equals(".lua")) {
                    list.add(f.getName());
                    System.out.println(name);
                }
            }
        }
        return list;
    }
}