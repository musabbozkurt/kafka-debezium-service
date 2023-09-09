package com.mb.kafkadebeziumservice;

import com.mb.kafkadebeziumservice.config.LocalKafkaInitializer;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class KafkaDebeziumServiceApplicationTests {

    public static void main(String[] args) {
        new SpringApplicationBuilder(KafkaDebeziumServiceApplication.class)
                .initializers(new LocalKafkaInitializer())
                .run(args);
    }

}
