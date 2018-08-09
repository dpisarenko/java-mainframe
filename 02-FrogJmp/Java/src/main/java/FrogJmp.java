public class FrogJmp {
    public int solution(final int x, final int y, final int d) {
        final double distance = (double) (y - x);
        return (int) Math.ceil(distance / d);
    }
}
