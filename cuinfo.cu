// Vasileios Valeras 4031


#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

/* 
 * Retrieves and prints information for every installed NVIDIA
 * GPU device
 */
void cuinfo_print_devinfo()
{
    int num_devs, i;
    cudaDeviceProp dev_prop;
    
    cudaGetDeviceCount(&num_devs);
    if (num_devs == 0)
    {
        printf("No CUDA devices found.\n");
        return;
    }
    
    for (i = 0; i < num_devs; i++)
    {
        cudaGetDeviceProperties(&dev_prop, i);
        
        printf("Device %d:\n", i);
        printf("\tName: %s\n", dev_prop.name);
        printf("\tCUDA Version: %d.%d\n", dev_prop.major, dev_prop.minor);
        printf("\tCompute Capability: %d.%d\n", dev_prop.major, dev_prop.minor);
        printf("\tStreaming Multiprocessors: %d\n", dev_prop.multiProcessorCount);
        printf("\tCUDA Cores: %d\n", 
            (dev_prop.major == 2 && dev_prop.minor == 1) ? dev_prop.multiProcessorCount * 48 :
            (dev_prop.major == 3) ? dev_prop.multiProcessorCount * 192 :
            (dev_prop.major == 5 && dev_prop.minor == 2) ? dev_prop.multiProcessorCount * 128 :
            (dev_prop.major == 5 && dev_prop.minor == 3) ? dev_prop.multiProcessorCount * 192 :
            (dev_prop.major == 6 && dev_prop.minor == 0) ? dev_prop.multiProcessorCount * 128 :
            (dev_prop.major == 6 && dev_prop.minor == 1) ? dev_prop.multiProcessorCount * 128 :
            (dev_prop.major == 7 && dev_prop.minor == 0) ? dev_prop.multiProcessorCount * 64 :
            dev_prop.multiProcessorCount * 128); // assuming architecture of compute capability 8.x and above
        printf("\tMax Threads per Block: %d\n", dev_prop.maxThreadsPerBlock);
        printf("\tTotal Global Memory: %lu bytes\n", dev_prop.totalGlobalMem);
        printf("\tShared Memory per Block: %lu bytes\n", dev_prop.sharedMemPerBlock);
    }
}


int main()
{
	cuinfo_print_devinfo();
	return 0;
}
