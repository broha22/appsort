include theos/makefiles/common.mk
export ARCHS = armv7 arm64
export SDKVERSION = 9.2
TWEAK_NAME = AppSort
AppSort_FILES = Tweak.x stats.xm
AppSort_FRAMEWORKS = Foundation UIKit CoreGraphics CoreImage QuartzCore
AppSort_LIBRARIES = activator
AppSort_OBJ_FILES = lua/liblua.a
ADDITIONAL_OBJCFLAGS = -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += appsort
include $(THEOS_MAKE_PATH)/aggregate.mk
