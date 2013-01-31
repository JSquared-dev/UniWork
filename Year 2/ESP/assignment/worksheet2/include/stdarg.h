 
#ifdef __cplusplus
extern "C" {
#endif

typedef char *va_list;

#define _ARCH_va_arg(list, type)	((type *)(list += sizeof(type)))[-1]
#define _ARCH_va_end(list)
#define _ARCH_va_start(list, last_arg)	(list = (va_list)(&last_arg + 1))

#define va_arg(list, type)		_ARCH_va_arg(list, type)
#define va_end(list)			_ARCH_va_end(list)
#define va_start(list, last_arg)	_ARCH_va_start(list, last_arg)

#ifdef __cplusplus
}
#endif

