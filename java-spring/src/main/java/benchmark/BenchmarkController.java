package benchmark;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
public class BenchmarkController {
    private static final String TEMPLATE = "Index %d";

    @RequestMapping("/framework")
    public Map<String, String> framework() {
        return Map.of("Hello", "world");
    }

    @RequestMapping("/benchmark")
    public Map<String, List> benchmark(@RequestParam(value = "count", defaultValue = "10000") Long count) {
        ArrayList<String> list = new ArrayList<>();
        for (long i = 0; i < count; i++) {
            list.add(String.format(TEMPLATE, i));
        }
        return Map.of("results", list.subList(0, 10));
    }
}
