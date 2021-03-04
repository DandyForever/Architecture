#include <benchmark/benchmark.h>
#include <iostream>
#include <vector>

using namespace std;

int SIZE = 64 * 1024 * 1024 / 4 / 4;
int SIZE_ = SIZE;
const int ACCESSED = 4096;

struct SoA {
    vector<int> x, y, z, w;
    SoA() : x(SIZE_), y(SIZE_), z(SIZE_), w(SIZE_) {}
};

void soa_scan(struct SoA &array, int stride) {
    for (int i = 0; i < SIZE; i += stride)
        array.x[i] = array.x[i] + array.y[i] << array.z[i];
}

static void CustomArguments(benchmark::internal::Benchmark* b) {
    for (int i = 1; i <= 1024; i++)
        b->Args({i, ACCESSED * i});
}

void soa_scan_bench(benchmark::State& state) {
    SoA soa = SoA();
    for (int i = 0; i < SIZE_; i++) {
        soa.x[i] = i;
        soa.y[i] = -i;
        soa.z[i] = SIZE_ - i;
        soa.w[i] = i - SIZE_;
    }
    SIZE = state.range(1);
    for (auto _ : state) {
        soa_scan(soa, state.range(0));
    }
}

int main() {
    benchmark::RegisterBenchmark("SoAScan", soa_scan_bench)->Apply(CustomArguments);
//    benchmark::RegisterBenchmark("SoAScan", soa_scan_bench)->Args({1, 4096})
//                                                           ->Args({2, 8192})
//                                                           ->Args({3, 12288});
    benchmark::RunSpecifiedBenchmarks();
    return 0;
}
