package com.mb.kafkadebeziumservice.api.controller;

import com.mb.kafkadebeziumservice.service.ProducerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/producer")
public class ProducerController {

    private final ProducerService producerService;

    @GetMapping
    public ResponseEntity<String> health() {
        log.info("Producer health is called.");
        return ResponseEntity.ok("Producer is running.");
    }

    @PostMapping("/{topic}")
    public ResponseEntity<String> publishToTopic(@PathVariable("topic") final String topic, @RequestBody String message) {
        producerService.publishMessage(topic, message);
        return ResponseEntity.ok("Message is published.");
    }

}
