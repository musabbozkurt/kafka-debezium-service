package com.mb.kafkadebeziumservice.service.impl;

import com.mb.kafkadebeziumservice.config.KafkaConsumerConfig;
import com.mb.kafkadebeziumservice.service.ConsumerService;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class ConsumerServiceImpl implements ConsumerService {

    private final KafkaConsumerConfig consumerConfig;
    public KafkaConsumer<Integer, String> ordersConsumer;

    public ConsumerServiceImpl(KafkaConsumerConfig consumerConfig) {
        this.consumerConfig = consumerConfig;
        this.ordersConsumer = consumerConfig.getOrdersConsumer();
    }

    @KafkaListener(topics = "${spring.kafka.topics.topic1}", groupId = "${spring.kafka.consumer.group-id}")
    public void consume(String message,
                        @Header(KafkaHeaders.RECEIVED_PARTITION) String receivedPartitionId,
                        @Header(KafkaHeaders.OFFSET) String offset) {
        log.info("Received a request to consume message. receivedPartitionId: {} offset: {} message: {}", receivedPartitionId, offset, message);
    }

    @KafkaListener(topics = "${spring.kafka.topics.topic2}", groupId = "${spring.kafka.consumer.group-id}")
    public void consumeInventoryCustomers(String message,
                                          @Header(KafkaHeaders.RECEIVED_PARTITION) String receivedPartitionId,
                                          @Header(KafkaHeaders.OFFSET) String offset) {
        log.info("Received a request to consume message. receivedPartitionId: {} offset: {} message: {}", receivedPartitionId, offset, message);
    }

    @Override
    public List<String> consumeOrders() {
        log.info("starting message consumption for topic: {}", ordersConsumer.subscription());
        ConsumerRecords<Integer, String> records = consumerConfig.getOrdersConsumer().poll(Duration.ofMillis(1000));
        List<String> response = new ArrayList<>();
        for (ConsumerRecord<Integer, String> record : records) {
            log.info("Received message: ({}) at offset {}", record.value(), record.offset());
            response.add(record.value());
        }
        return response;
    }
}
