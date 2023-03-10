#include <benchmark/benchmark.h>

#include <ndvector/ndvector.h>

static void BM_ndvector(benchmark::State& state)
{
    for (auto _ : state) {
    }
}
BENCHMARK(BM_ndvector);

