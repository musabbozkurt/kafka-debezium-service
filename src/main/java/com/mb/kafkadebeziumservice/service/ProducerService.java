package com.mb.kafkadebeziumservice.service;

public interface ProducerService {

    void publishMessage(String topicName, String message);
}
