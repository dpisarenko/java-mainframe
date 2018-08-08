public class BinaryGap {
    public int solution(final int N) {
        final String binStr = Integer.toBinaryString(N);
        int largestGapSize = 0;
        int curGapSize = 0;
        for (int i=0; i < binStr.length(); i++) {
            final char curChar = binStr.charAt(i);
            if (curChar == '0') {
                curGapSize++;
            } else {
                largestGapSize = Math.max(largestGapSize, curGapSize);
                curGapSize = 0;
            }
        }
        return largestGapSize;
    }
}
