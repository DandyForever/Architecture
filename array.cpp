#include <benchmark/benchmark.h>
#include <vector>

using namespace std;

int SIZE = 64 * 1024 * 1024 / 4 / 4;
const int ACCESSED = 4096;

void aos_scan(vector<int> &array, int stride) {
    for (int i = 0; i < SIZE; i += stride)
        array[i] = array[i] << 1;
}

static void CustomArguments(benchmark::internal::Benchmark* b) {
    for (int i = 1; i <= 1024; i++)
        b->Args({i, ACCESSED * i});
}

void aos_scan_bench(benchmark::State& state) {
    std::vector<int> array(64 * 1024 * 1024 / 4 / 4);
    for (int i = 0; i < 64 * 1024 * 1024 / 4 / 4; i++) {
        array[i] = i;
    }
    SIZE = state.range(1);
    for (auto _ : state) {
        aos_scan(array, state.range(0));
    }
}

int main() {
    benchmark::RegisterBenchmark("AoSScan", aos_scan_bench)->Apply(CustomArguments);
    //benchmark::RegisterBenchmark("AoSScan", aos_scan_bench)->Args({1, 4096})
    //                                                       ->Args({2, 8192})
    //                                                       ->Args({3, 12288});
    benchmark::RunSpecifiedBenchmarks();
    return 0;
}
