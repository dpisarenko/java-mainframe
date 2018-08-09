import org.junit.Assert;
import org.junit.Test;

public class FrogJmpTests {
    @Test
    public void test() {
        testLogic(10, 85, 30, 3);
    }

    private void testLogic(final int x, final int y, final int d, 
                    final int expRes) {
        final FrogJmp sut = new FrogJmp();
        final int actRes = sut.solution(x, y, d);
        Assert.assertEquals(expRes, actRes);
    }
}
