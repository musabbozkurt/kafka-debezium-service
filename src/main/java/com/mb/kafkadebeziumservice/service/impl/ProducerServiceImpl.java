package com.mb.kafkadebeziumservice.service.impl;

import com.mb.kafkadebeziumservice.service.ProducerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProducerServiceImpl implements ProducerService {

    private final KafkaTemplate<String, String> kafkaTemplate;

    @Override
    public void publishMessage(String topicName, String message) {
        log.info(String.format("Message sent --> %s", message));
        this.kafkaTemplate.send(topicName, message);
    }
}
