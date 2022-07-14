#include <iostream>
#include <math.h>
// Kernel function to add the elements of two arrays
__global__
void add(int n, int m, float *x, float *y)
{
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int stride = blockDim.x * gridDim.x;
  for(int i = 0; i < n; i++)
    for (int j = index; j < m; j += stride)
      x[i * m + j] += y[j];
}

int main(void)
{
  int N = 1<<10;
  int M = 1<<20;
  float *x, *y;

  // Allocate Unified Memory – accessible from CPU or GPU
  cudaMallocManaged(&x, N * M * sizeof(float));
  cudaMallocManaged(&y, M * sizeof(float));

  // initialize x and y arrays on the host
  for (int i = 0; i < M; i++)
    y[i] = 2.0f;

  for(int i = 0; i < N; i++)
    for(int j = 0; j < M; j++)
      x[i * M + j] = 1.0f;

  // Run kernel on 1M elements on the GPU
  int blocksize = 256;
  int numblocks = (M + blocksize - 1) / blocksize;
  add<<<numblocks, blocksize>>>(N, M, x, y);

  // Wait for GPU to finish before accessing on host
  cudaDeviceSynchronize();

  // Check for errors (all values should be 3.0f)
  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
    for(int j = 0; j < M; j++)
      maxError = fmax(maxError, fabs(x[i * M + j]-3.0f));
  std::cout << "Max error: " << maxError << std::endl;

  // Free memory
  cudaFree(x);
  cudaFree(y);

  return 0;
}