package mcp;

import java.util.function.Function;

public class DemoFunction implements Function<String, String> {
	public String apply(String s) {
		return new StringBuilder(s).reverse().toString();
	}
}