import org.junit.Assert;
import org.junit.Test;

public class BinaryGapTests {
    @Test
    public void test() {
        testLogic(1041, 5);
        testLogic(32, 0);
    }

    private void testLogic(final int n, final int expRes) {
        final BinaryGap sut = new BinaryGap();
        final int actRes = sut.solution(n);
        Assert.assertEquals(expRes, actRes);
    }
}
