package utils;

import com.google.gson.Gson;
import com.google.gson.JsonArray;

import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;

public class JsonParse {

    private Gson gson;

    public JsonParse() {
        gson = new Gson();
    }

    @SuppressWarnings("unchecked")
    public Map<String, String> getMapFromJson(String json) throws IOException {
        Reader reader = Files.newBufferedReader(Paths.get(json));
        Map<String, String> map = (Map<String, String>) gson.fromJson(reader, Map.class);
        reader.close();
        return map;
    }

    @SuppressWarnings("unchecked")
    public Map<String, ArrayList> getArrayListMapFromJson(String json) throws IOException {
        Reader reader = Files.newBufferedReader(Paths.get(json));
        Map<String, ArrayList> map = (Map<String, ArrayList>) gson.fromJson(reader, Map.class);
        reader.close();
        return map;
    }
}
