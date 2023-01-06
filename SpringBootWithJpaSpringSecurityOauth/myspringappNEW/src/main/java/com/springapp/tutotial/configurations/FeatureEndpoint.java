package com.springapp.tutotial.configurations;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import net.bytebuddy.asm.Advice;
import org.springframework.boot.actuate.endpoint.annotation.*;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
@Endpoint(id="features")
public class FeatureEndpoint {
    private final Map<String, Feature> map = new ConcurrentHashMap<>();
    public FeatureEndpoint() {
        map.put("FeatureA", new Feature(true));
        map.put("FeatureB", new Feature(false));
        map.put("FeatureC", new Feature(true));
    }
    //http://localhost:8088/actuator/features
    @ReadOperation
    public Map<String, Feature> getFeatures() {
        return map;
    }
    //http://localhost:8088/actuator/features/FeatureB
    @ReadOperation
    public Feature getFeature(@Selector String featureName) {
        return map.get(featureName);
    }
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    private static class Feature {
        private boolean isEnabled;
    }

}
