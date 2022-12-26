TARGET=asap1
TOP=asap1

OBJS+=asap1.v clock.v control.v memory.v alu.v register.v program_counter.v register_counter.v

all: ${TARGET}.bit

$(TARGET).json: $(OBJS)
	yosys -p "synth_ecp5 -top ${TOP} -json $@" $(OBJS)

$(TARGET)_out.config: $(TARGET).json
	nextpnr-ecp5 --verbose --25k --package CABGA381 --speed 6 --json $< --textcfg $@ --lpf $(TARGET).lpf --freq 65

$(TARGET).bit: $(TARGET)_out.config
	ecppack --compress --svf ${TARGET}.svf $< $@

${TARGET}.svf: ${TARGET}.bit

prog: ${TARGET}.bit
	ecpdap --freq 10000 program $(TARGET).bit

flash: ${TARGET}.bit
	ecpdap --freq 10000 flash write $(TARGET).bit

clean:
	rm -f *.svf *.bit *.out *.vcd *.config *.json *.ys hardware*

.PHONY: all prog flash clean
