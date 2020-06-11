/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <io.h>
#include <system.h>
#include <stdint.h>
#include <unistd.h>


#define ALT_CI_BITSWAP_N 0x00
#define ALT_CI_BITSWAP(A) __builtin_custom_ini(ALT_CI_BITSWAP_N, (A))

uint32_t Swap(int a, int b, uint32_t data);
uint32_t SwapTP2(uint32_t res);
void printb(uint32_t);

//int main(void)
int main2(void)
{
	uint32_t res;
	int i = 0;
	int lim = 100000000;
	printf("Main function starting\n");
	for (i = 0; i < lim; i++)
	{
		res = 1;
		/*
		printf("Before : %lu\n", res);
		printb(res);
		*/
		res = SwapTP2(res);


		/*
		printf("After : %lu\n", res);
		printb(res);
		 */
	}


	exit(EXIT_SUCCESS);
}

uint32_t SwapTP2(uint32_t res)
{
	/*
	res = Swap(24, 0, res);
	res = Swap(25, 1, res);
	res = Swap(26, 2, res);
	res = Swap(27, 3, res);
	res = Swap(28, 4, res);
	res = Swap(29, 5, res);
	res = Swap(30, 6, res);
	res = Swap(31, 7, res);

	res = Swap(23, 8, res);
	res = Swap(22, 9, res);
	res = Swap(21, 10, res);
	res = Swap(20, 11, res);
	res = Swap(19, 12, res);
	res = Swap(18, 13, res);
	res = Swap(17, 14, res);
	res = Swap(16, 15, res);
	*/
	res = ALT_CI_BITSWAP(res);

	return res;
}

uint32_t Swap(int a, int b, uint32_t data)
{
	if (((data & (1 << a)) >> a) ^ ((data & (1 << b)) >> b))
	{
		data ^= (1 << a);
		data ^= (1 << b);
	}

	return data;
}

void printb(uint32_t res)
{
	unsigned int i, s = 1<<((sizeof(res)<<3)-1);

    for (i = s; i; i>>=1)
		printf("%d", (res & i) || 0 );


	printf("\n");
}
