REBOOTEXBIN = Rebootex_bin
REBOOTEX = Rebootex
INSTALLER = Installer
VSHCONTROL = Vshctrl
SYSTEMCONTROL = SystemControl
SYSTEMCONTROLPXE = PXE/SystemControlPXE
REBOOTEXPXE = PXE/RebootexPXE
LAUNCHER = PXE/Launcher
GALAXYDRIVER = ISODrivers/Galaxy
M33DRIVER = ISODrivers/March33
INFERNO = ISODrivers/Inferno
STARGATE = Stargate
SATELITE = Satelite
POPCORN = Popcorn
RECOVERY = Recovery
USBDEVICE=usbdevice
CROSSFW = CrossFW
DISTRIBUTE = dist
OPT_FLAGS=

all:
# Preparing Distribution Folders
	@mkdir -p $(DISTRIBUTE) || true
	@mkdir -p $(DISTRIBUTE)/seplugins/ || true
	@cp -r contrib/fonts $(DISTRIBUTE)/seplugins/fonts || true
	@cp Translated/* $(DISTRIBUTE)/seplugins || true
	@mkdir -p $(DISTRIBUTE)/PSP || true
	@mkdir -p $(DISTRIBUTE)/PSP/GAME || true
	@mkdir -p $(DISTRIBUTE)/PSP/GAME/uOFW || true
	@rm -f ./Common/*.o

# Creating CrossFW library
	@cd $(CROSSFW); make $(OPT_FLAGS) $(DEBUG_OPTION)

# Creating Live-System Reboot Buffer
	@cd $(REBOOTEXBIN); make $(OPT_FLAGS)
	@cd $(REBOOTEX); make $(OPT_FLAGS) $(DEBUG_OPTION)

# Creating Live-System Components
	@cd $(RECOVERY); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@rm -f ./Common/*.o
	@cd $(VSHCONTROL); make $(OPT_FLAGS) $(DEBUG_OPTION) $(NIGHTLY_OPTION)
	@cd $(USBDEVICE); make $(OPT_FLAGS) $(DEBUG_OPTION) $(NIGHTLY_OPTION)
	@cd $(SYSTEMCONTROL); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@cd $(GALAXYDRIVER); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@cd $(INFERNO); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@cd $(STARGATE); make $(OPT_FLAGS) $(DEBUG_OPTION) $(RELEASE_OPTION)
	@cd $(SATELITE); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@cd $(POPCORN); make $(OPT_FLAGS) $(DEBUG_OPTION)

# Creating PXE Executable
	@cd $(INSTALLER); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@cd $(SYSTEMCONTROLPXE); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@cd $(REBOOTEXPXE); make $(OPT_FLAGS)
	@mv $(REBOOTEXPXE)/rebootex.h $(LAUNCHER)
	@cd $(LAUNCHER); make $(OPT_FLAGS) $(DEBUG_OPTION)
	@mv $(LAUNCHER)/EBOOT.PBP $(DISTRIBUTE)/PSP/GAME/uOFW

clean:
	@cd $(REBOOTEXBIN); make clean $(DEBUG_OPTION)
	@cd $(CROSSFW); make clean $(DEBUG_OPTION)
	@cd $(REBOOTEX); make clean $(DEBUG_OPTION)
	@cd $(INSTALLER); make clean $(DEBUG_OPTION)
	@cd $(VSHCONTROL); make clean $(DEBUG_OPTION)
	@cd $(USBDEVICE); make clean $(DEBUG_OPTION)
	@cd $(SYSTEMCONTROL); make clean $(DEBUG_OPTION)
	@cd $(GALAXYDRIVER); make clean $(DEBUG_OPTION)
	@cd $(INFERNO); make clean $(DEBUG_OPTION)
	@cd $(STARGATE); make clean $(DEBUG_OPTION) $(RELEASE_OPTION)
	@cd $(SATELITE); make clean $(DEBUG_OPTION)
	@cd $(LAUNCHER); make clean $(DEBUG_OPTION)
	@cd $(REBOOTEXPXE); make clean $(DEBUG_OPTION)
	@cd $(SYSTEMCONTROLPXE); make clean $(DEBUG_OPTION)
	@cd $(POPCORN); make clean $(DEBUG_OPTION)
	@cd $(RECOVERY); make clean $(DEBUG_OPTION)
	@rm -rf $(DISTRIBUTE)

deps:
	make clean_lib
	make build_lib

build_lib:
	@cd $(SYSTEMCONTROL)/libs; make $(OPT_FLAGS) $(DEBUG_OPTION)
	
clean_lib:
	@cd $(SYSTEMCONTROL)/libs; make clean $(DEBUG_OPTION)
