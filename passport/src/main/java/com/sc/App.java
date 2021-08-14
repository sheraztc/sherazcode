package com.sc;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.StringUtils;

/**
 *
 * Here is an example batch file containing four passports:
 *
 * ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
 * byr:1937 iyr:2017 cid:147 hgt:183cm
 *
 * iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
 * hcl:#cfa07d byr:1929
 *
 * hcl:#ae17e1 iyr:2013
 * eyr:2024
 * ecl:brn pid:760753108 byr:1931
 * hgt:179cm
 *
 * hcl:#cfa07d eyr:2025 pid:166559648
 * iyr:2011 ecl:brn hgt:59in
 *
 * The first passport is valid - all eight fields are present. The second passport is invalid - it is missing hgt (the Height field).
 * The third passport is interesting; the only missing field is cid, treat this as a valid password
 * The fourth passport is missing two fields, cid and byr. Missing cid is fine, but missing any other field is not, so this passport is invalid.
 * According to the above rules, you would report 2 valid passports.
 * Count the number of valid passports - those that have all required fields. Treat cid as optional. In your batch file, how many passports are valid?
 */
public class App {
    public static void main(String[] args) {

        Arrays.asList("byr",
                "iyr",
                "eyr",
                "hgt",
                "hcl",
                "ecl",
                "pid",
                "cid");
        List<String> lines = null;
        try {
            lines = Files.readAllLines(Paths.get("passport_input.txt"));
        } catch (IOException e) {
            e.printStackTrace();
        }


        // parse string. Create separate records in String
        //
        // X Convert String records in Passport objects
        // Validate Passport objects
        // Show output


        List<String> records = new ArrayList<>();
        StringBuilder record = new StringBuilder();
        for (String line : lines) {
            if (StringUtils.isNotBlank(line)) {
                record.append(line).append(' ');
            }
            if (StringUtils.isBlank(line)) {
                records.add(record.toString());
                record = new StringBuilder();
            }
        }

        System.out.println(records);


    }
}
