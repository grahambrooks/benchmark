package benchmark;

import java.util.ArrayList;
import java.util.Map;

import static benchmark.JsonUtil.json;
import static spark.Spark.get;
import static spark.Spark.port;

public class BenchmarkService {
    public static void main(String[] args) {
        port(8080);
        String TEMPLATE = "Index %d";

        get("/feature", (req, res)-> Map.of("Hello", "world"), json());

        get("/benchmark", (req, res) -> {
            int count = req.queryParams("count") == null ? 10000 : Integer.parseInt(req.queryParams("count"));

            ArrayList<String> list = new ArrayList<>();

            for (long i = 0; i < count; i++) {
                list.add(String.format(TEMPLATE, i));
            }

            return JsonUtil.toJson(Map.of("results", list.subList(0, 10)));
        });
    }
}
