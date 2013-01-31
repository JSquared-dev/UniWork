
struct stdfn {
	void (*write)(const char *buffer, int len);
	int  (*read)(char *buffer, int nr);
	int  (*stat)(void);
        void (*init)(void);
};

extern struct stdfn stdfn;
