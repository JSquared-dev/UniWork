/*
 *  config.h
 *
 *  Configuration file for BIOS
 *
 *  (C) 1998 Russell King.
 *
 *  Please report bugs to rmk@arm.uk.linux.org
 *
 * Edit this file to select your preferences.  By default, it comes with
 * most options enabled, and as such, the resulting BIOS should work with
 * the majority of systems (provided that the peripherals are supported).
 */

/*============================================================================
 * Boot device configuration
 *
 * These options control which types of devices will be compiled into the
 * BIOS.  The available devices are:
 *  - Boot from network using BOOTP/TFTP protocol
 *  - Boot from IDE hard drive
 *  - Boot from SCSI hard drive (not implemented)
 */

/* Define this if you wish your machine to have the capability of booting
 * using an image stored on another machine via a TCP/IP network.
 */
#define CONFIG_BOOT_NET

/* Define this if you wish your machine to have the capability of booting
 * from an IDE hard disk.
 */
#define CONFIG_BOOT_IDE

/* Define this if you wish your machine to have the capability of booting
 * from a SCSI hard disk.
 */
#undef CONFIG_BOOT_SCSI

/*============================================================================
 * Network Configuration
 */
#ifdef CONFIG_BOOT_NET
/* Define this if you wish to use the BOOTP protocol to obtain the IP address
 * of this machine.  If you do not define this, then you will have to specify
 * the IP address of this machine.
 */
#define CONFIG_NET_BOOTP

#ifndef CONFIG_NET_BOOTP
/* If the BIOS is not going to have BOOTP support, then you will have to
 * specify the IP address and netmask of this machine.
 */
#define CONFIG_NET_IP		192.168.0.4
#define CONFIG_NET_NETMASK	255.255.255.0
#endif

/* Device driver selection.  You must compile in at least one driver for
 * CONFIG_BOOT_NET to be useful.  Currently supported cards are:
 *  - 3com 3c59x cards.
 *  - DEC 21041
 */
#define CONFIG_NET_3COM_3C59X
#define CONFIG_NET_DEC_21041
#endif

/*============================================================================
 * IDE configuration
 */
#ifdef CONFIG_BOOT_IDE
/* Device driver selection.  You must compile in at least one driver for
 * CONFIG_BOOT_IDE to be useful.  Currently supported cards are:
 *  - Promise IDE
 */
#define CONFIG_IDE_PROMISE
#endif

/*============================================================================
 * SCSI configuration
 */
#ifdef CONFIG_BOOT_SCSI
/* Device driver selection.  You must compile in at least one driver for
 * CONFIG_BOOT_SCSI to be useful.  Currently supported cards are:
 */
#endif

