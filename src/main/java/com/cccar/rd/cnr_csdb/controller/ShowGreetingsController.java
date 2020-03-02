package com.cccar.rd.cnr_csdb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShowGreetingsController {

    @GetMapping("/")
    public String index(){
        return "index";
    }

}