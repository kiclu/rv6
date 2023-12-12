#define FIB_N 25

int main() {
    int fib[FIB_N+1];
    fib[0] = 0;
    fib[1] = 1;

    for(int i = 2; i <= FIB_N; ++i) {
        fib[i] = fib[i-1] + fib[i-2];
    }

    return fib[FIB_N];
}
