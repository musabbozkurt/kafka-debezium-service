package com.mb.kafkadebeziumservice.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.env.PropertySource;
import org.springframework.lang.NonNull;
import org.testcontainers.containers.KafkaContainer;
import org.testcontainers.utility.DockerImageName;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Configuration
public class LocalKafkaInitializer implements ApplicationContextInitializer<ConfigurableApplicationContext> {

    @Override
    public void initialize(@NonNull ConfigurableApplicationContext context) {
        kafkaLocalSetup(context);
    }

    private void kafkaLocalSetup(ConfigurableApplicationContext context) {
        ConfigurableEnvironment environment = context.getEnvironment();
        KafkaContainer kafka = new KafkaContainer(DockerImageName.parse("confluentinc/cp-kafka:7.5.0"))
                .withEnv("KAFKA_AUTO_CREATE_TOPICS_ENABLE", "true")
                .withEnv("KAFKA_CREATE_TOPICS", "kafka_topic");
        kafka.start();
        setProperties(environment, kafka.getBootstrapServers());
    }

    private void setProperties(ConfigurableEnvironment environment, String value) {
        MutablePropertySources sources = environment.getPropertySources();
        PropertySource<?> source = sources.get("kafka.config.bootstrap-server");
        if (source == null) {
            source = new MapPropertySource("kafka.config.bootstrap-server", new HashMap<>());
            sources.addFirst(source);
        }
        ((Map<String, String>) source.getSource()).put("kafka.config.bootstrap-server", value);
    }
}