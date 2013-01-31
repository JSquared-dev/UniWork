#define PCI_VENDOR_ID		0
#define PCI_DEVICE_ID		2

#define PCI_COMMAND		4
#define PCI_COMMAND_SERR_ENABLE		(1 << 8)
#define PCI_COMMAND_PERR_ENABLE		(1 << 6)
#define PCI_COMMAND_DAC_SNOOP		(1 << 5)
#define PCI_COMMAND_BUS_MASTER		(1 << 2)
#define PCI_COMMAND_MEM_SPACE		(1 << 1)
#define PCI_COMMAND_IO_SPACE		(1 << 0)

#define PCI_STATUS		6

#define PCI_CLASS_CODE		8

#define PCI_LATENCY_TIMER	13

#define PCI_HEADER_TYPE		14

#define PCI_BASE0		16
#define PCI_BASE1		20
#define PCI_BASE2		24
#define PCI_BASE3		28
#define PCI_BASE4		32
#define PCI_BASE5		36

#define PCI_BIOSROMCONTROL	48

#define PCI_INTERRUPT_LINE	60
#define PCI_INTERRUPT_PIN	61
#define PCI_MINGNT		62
#define PCI_MAXLAT		63

#define PCI_CLASS_NOT_DEFINED           0x0000
#define PCI_CLASS_NOT_DEFINED_VGA       0x0001

#define PCI_BASE_CLASS_STORAGE          0x01
#define PCI_CLASS_STORAGE_SCSI          0x0100
#define PCI_CLASS_STORAGE_IDE           0x0101
#define PCI_CLASS_STORAGE_FLOPPY        0x0102
#define PCI_CLASS_STORAGE_IPI           0x0103
#define PCI_CLASS_STORAGE_RAID          0x0104
#define PCI_CLASS_STORAGE_OTHER         0x0180

#define PCI_BASE_CLASS_NETWORK          0x02
#define PCI_CLASS_NETWORK_ETHERNET      0x0200
#define PCI_CLASS_NETWORK_TOKEN_RING    0x0201
#define PCI_CLASS_NETWORK_FDDI          0x0202
#define PCI_CLASS_NETWORK_ATM           0x0203
#define PCI_CLASS_NETWORK_OTHER         0x0280

#define PCI_BASE_CLASS_DISPLAY          0x03
#define PCI_CLASS_DISPLAY_VGA           0x0300
#define PCI_CLASS_DISPLAY_XGA           0x0301
#define PCI_CLASS_DISPLAY_OTHER         0x0380

#define PCI_BASE_CLASS_MULTIMEDIA       0x04
#define PCI_CLASS_MULTIMEDIA_VIDEO      0x0400
#define PCI_CLASS_MULTIMEDIA_AUDIO      0x0401
#define PCI_CLASS_MULTIMEDIA_OTHER      0x0480

#define PCI_BASE_CLASS_MEMORY           0x05
#define  PCI_CLASS_MEMORY_RAM           0x0500
#define  PCI_CLASS_MEMORY_FLASH         0x0501
#define  PCI_CLASS_MEMORY_OTHER         0x0580

#define PCI_BASE_CLASS_BRIDGE           0x06
#define  PCI_CLASS_BRIDGE_HOST          0x0600
#define  PCI_CLASS_BRIDGE_ISA           0x0601
#define  PCI_CLASS_BRIDGE_EISA          0x0602
#define  PCI_CLASS_BRIDGE_MC            0x0603
#define  PCI_CLASS_BRIDGE_PCI           0x0604
#define  PCI_CLASS_BRIDGE_PCMCIA        0x0605
#define  PCI_CLASS_BRIDGE_NUBUS         0x0606
#define  PCI_CLASS_BRIDGE_CARDBUS       0x0607
#define  PCI_CLASS_BRIDGE_OTHER         0x0680


#define PCI_BASE_CLASS_COMMUNICATION    0x07
#define PCI_CLASS_COMMUNICATION_SERIAL  0x0700
#define PCI_CLASS_COMMUNICATION_PARALLEL 0x0701
#define PCI_CLASS_COMMUNICATION_OTHER   0x0780

#define PCI_BASE_CLASS_SYSTEM           0x08
#define PCI_CLASS_SYSTEM_PIC            0x0800
#define PCI_CLASS_SYSTEM_DMA            0x0801
#define PCI_CLASS_SYSTEM_TIMER          0x0802
#define PCI_CLASS_SYSTEM_RTC            0x0803
#define PCI_CLASS_SYSTEM_OTHER          0x0880

#define PCI_BASE_CLASS_INPUT            0x09
#define PCI_CLASS_INPUT_KEYBOARD        0x0900
#define PCI_CLASS_INPUT_PEN             0x0901
#define PCI_CLASS_INPUT_MOUSE           0x0902
#define PCI_CLASS_INPUT_OTHER           0x0980

#define PCI_BASE_CLASS_DOCKING          0x0a
#define PCI_CLASS_DOCKING_GENERIC       0x0a00
#define PCI_CLASS_DOCKING_OTHER         0x0a01

#define PCI_BASE_CLASS_PROCESSOR        0x0b
#define PCI_CLASS_PROCESSOR_386         0x0b00
#define PCI_CLASS_PROCESSOR_486         0x0b01
#define PCI_CLASS_PROCESSOR_PENTIUM     0x0b02
#define PCI_CLASS_PROCESSOR_ALPHA       0x0b10
#define PCI_CLASS_PROCESSOR_POWERPC     0x0b20
#define PCI_CLASS_PROCESSOR_CO          0x0b40

#define PCI_BASE_CLASS_SERIAL           0x0c
#define PCI_CLASS_SERIAL_FIREWIRE       0x0c00
#define PCI_CLASS_SERIAL_ACCESS         0x0c01
#define PCI_CLASS_SERIAL_SSA            0x0c02
#define PCI_CLASS_SERIAL_USB            0x0c03
#define PCI_CLASS_SERIAL_FIBER          0x0c04

#define PCI_CLASS_OTHERS                0xff


static inline unsigned long pci_config_addr(int slot, int func)
{
	return 0x7bc00000 + (slot << 11) + (func << 8);
}

static inline unsigned long read_long(unsigned long addr)
{
	return *(volatile unsigned long *)addr;
}

static inline void write_long(unsigned long data, unsigned long addr)
{
	*(volatile unsigned long *)addr = data;
}

static inline unsigned int read_word(unsigned long addr)
{
	unsigned short ret;

	__asm__ __volatile__("ldrh %0, [%1]" : "=r" (ret) : "r" (addr));

	return ret;
}

static inline void write_word(unsigned int data, unsigned long addr)
{
	__asm__ __volatile__("strh %0, [%1]" : : "r" (data), "r" (addr));
}

static inline unsigned char read_byte(unsigned long addr)
{
	return *(volatile unsigned char *)addr;
}

static inline void write_byte(unsigned char data, unsigned long addr)
{
	*(volatile unsigned char *)addr = data;
}

#define pci_read_config_long(b,x)	read_long((b) + (x))
#define pci_read_config_word(b,x)	read_word((b) + (x))
#define pci_read_config_byte(b,x)	read_byte((b) + (x))

#define pci_write_config_long(b,x,d)	write_long((d), (b) + (x))
#define pci_write_config_word(b,x,d)	write_word((d), (b) + (x))
#define pci_write_config_byte(b,x,d)	write_byte((d), (b) + (x))

#define pci_io_read_long(x)		read_long(0x7c000000 + (x))
#define pci_io_read_word(x)		read_word(0x7c000000 + (x))
#define pci_io_read_byte(x)		read_byte(0x7c000000 + (x))

#define pci_io_write_long(d,x)		write_long((d), 0x7c000000 + (x))
#define pci_io_write_word(d,x)		write_word((d), 0x7c000000 + (x))
#define pci_io_write_byte(d,x)		write_byte((d), 0x7c000000 + (x))

extern void pci_init(void);
extern unsigned long pci_lookupclass(unsigned short class);
extern unsigned long pci_lookup_vendor_device(unsigned short vendor_id, unsigned short device_id);
extern void pci_print_config(void);
