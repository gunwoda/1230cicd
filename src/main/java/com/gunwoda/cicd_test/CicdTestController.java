package com.gunwoda.cicd_test;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CicdTestController {
    @GetMapping("")
    public String test() {
        return "Hello World";
    }
}
