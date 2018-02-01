package com.codepub.demo;

import java.util.Arrays;
import java.util.List;
import java.util.function.Supplier;

public class DemoSupplier implements Supplier<String> {
    public String get() {
        return kingsBook.get(
                (int)Math.random()*kingsBook.size()
        );
    }

    List<String> kingsBook = Arrays.asList(new String[]{
            "YKCOWREBBAJ",
            "sevot yhtils eht dna,gillirb sawT’",
            "ebaw eht ni elbmig dna eryg diD",
            ",sevogorob eht erew ysmim llA",
            ".ebargtuo shtar emom eht dnA"
    });
}