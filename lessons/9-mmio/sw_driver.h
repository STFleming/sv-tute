// Arduino-like software driver for the custom MMIO interface 
//
//  author: stf

extern void regWrite(uint32_t addr, uint32_t data); 
extern uint32_t regRead(uint32_t addr); 
extern void exit();

uint32_t val;
uint32_t res;

// runs once on startup
void setup() {
        val = 42;
}

// runs continuously
void loop() {
        regWrite(0xFFFF0004, val++);
	res = regRead(0xFFFF0004);
	fprintf(stderr, "res=%u\n", res);
	exit();
}

