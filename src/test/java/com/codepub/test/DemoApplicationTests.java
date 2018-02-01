package com.codepub.test;

import com.codepub.demo.DemoConsumer;
import com.codepub.demo.DemoFunction;
import com.codepub.demo.DemoSupplier;
import org.assertj.core.api.Assertions;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

public class DemoApplicationTests {

	@Rule
	public ExpectedException thrown = ExpectedException.none();

	@Test
	public void testShouldExecFunction() {
		DemoFunction demoFn = new DemoFunction();
		String test = demoFn.apply("foo");

		Assertions.assertThat(test).isNotEmpty();
	}

	@Test
	public void testShouldConsume() {
		DemoConsumer demoFn = new DemoConsumer();
		demoFn.accept("foo");
	}

	@Test
	public void testShouldSupplyData() {
		DemoSupplier demoFn = new DemoSupplier();
		String test = demoFn.get();

		Assertions.assertThat(test).isNotNull();
	}
}