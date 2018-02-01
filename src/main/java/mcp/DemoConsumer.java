package mcp;

import lombok.extern.java.Log;

import java.util.function.Consumer;

@Log
public class DemoConsumer implements Consumer<String> {

    public void accept(String s) {
        log.info(s);
    }
}