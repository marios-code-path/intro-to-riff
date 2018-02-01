package mcp;

import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.function.Supplier;

public class DemoSupplier implements Supplier<String> {

	private List<String> kingsBook = Arrays.asList(
			"YKCOWREBBAJ",
			"sevot yhtils eht dna,gillirb sawT’",
			"ebaw eht ni elbmig dna eryg diD",
			",sevogorob eht erew ysmim llA",
			".ebargtuo shtar emom eht dnA");

	private final Random random = new Random();

	public String get() {
		int r = random.nextInt() * kingsBook.size();
		return kingsBook.get(r);
	}
}