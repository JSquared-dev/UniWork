#define CSR_PCI_CMD		0x004
#define CSR_CSRMEMBASE		0x010
#define CSR_CSRIOBASE		0x014
#define CSR_SDRAMBASE		0x018
#define CSR_OIMR		0x034
#define CSR_CSRBASEADDRMASK	0x0f8
#define CSR_CSRBASEADDR		0x0fc
#define CSR_SDRAMBASEADDRMASK	0x100
#define CSR_SDRAMBASEOFF	0x104
#define CSR_CTRL		0x13c
#define CSR_CTRL_INITCOMPLETE	(1 << 0)
#define CSR_PCIEXTN		0x140
#define CSR_DPMR		0x150
#define CSR_DSMR		0x154

#define CSR_IRQ_STATUS		0x180
#define CSR_IRQ_ENABLE		0x188
#define CSR_IRQ_DISABLE		0x18c

#define CSR_FIQ_STATUS		0x280
#define CSR_FIQ_ENABLE		0x288
#define CSR_FIQ_DISABLE		0x28c

#define CSR_TIMER1_LOAD		0x300
#define CSR_TIMER1_VALUE	0x304
#define CSR_TIMER1_CNTL		0x308
#define CSR_TIMER1_CLR		0x30c

#define TIMER_CNTL_ENABLE	(1 << 7)
#define TIMER_CNTL_AUTORELOAD	(1 << 6)
#define TIMER_CNTL_DIV1 	(0)
#define TIMER_CNTL_DIV16	(1 << 2)
#define TIMER_CNTL_DIV256	(2 << 2)
#define TIMER_CNTL_CNTEXT	(3 << 2)

#define CLOCK_TICK_RATE		50000000

typedef unsigned long	csr_long_t;
typedef unsigned int	csr_word_t;

static inline void csr_write_long(csr_long_t data, int offset)
{
	__asm__("str %0, [%1, %2]" : : "r" (data), "r" (0x42000000), "Jr" (offset));
}

static inline void csr_write_word(csr_word_t data, int offset)
{
	__asm__("strh %0, [%1]" : : "r" (data), "r" (0x42000000 + offset));
}

static inline csr_long_t csr_read_long(int offset)
{
	csr_long_t data;

	__asm__("ldr %0, [%1, %2]" : "=r" (data) : "r" (0x42000000), "Jr" (offset));

	return data;
}

static inline csr_word_t csr_read_word(int offset)
{
	csr_word_t data;

	__asm__("ldrh %0, [%1]" : "=r" (data) : "r" (0x42000000 + offset));

	return data;
}


