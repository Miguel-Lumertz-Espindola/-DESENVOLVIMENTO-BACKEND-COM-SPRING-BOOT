package com.example.security.controller;

import com.example.security.doc.TesteControllerDoc;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TesteController implements TesteControllerDoc {

    @Override
    @GetMapping(produces = "text/plain")
    public String test() {
        return "Testando seg";
    }
}