# The default options are compiling with debugging information
mode = debug

CC  = gcc
CXX = g++

# Source file directory
I18N_SRC = i18n_ts/

# QDBus XML file and the installation directory
INSTALL_DIR = /usr/local/ukui-screensaver

# bin file installation directory
BIN_DIR = /usr/bin

# gsettings xml file
GSETTINGS_DIR = /usr/share/glib-2.0/schemas

# Set build options
ifeq ($(mode), debug)
	# Compile with debugging information
	QMAKE_OPTIONS = CONFIG+=debug
else
	# Compile without debugging information
	QMAKE_OPTIONS =
endif

# Target
all: gui i18n command

#
# Compilation
#

# Compile GUI
gui:
	qmake $(QMAKE_OPTIONS) -o QtMakefile
	make -f QtMakefile

# Generate Qt translation file
i18n:
	$(MAKE) -C $(I18N_SRC)

command:
	$(CC) ukui-screensaver-command.c -o ukui-screensaver-command

#
# Installation
#

install: install-gui install-i18n install-data

install-gui:
	# Install GUI
	install -D ukui-screensaver $(DESTDIR)$(BIN_DIR)/ukui-screensaver
	install -D ukui-screensaver-command $(DESTDIR)$(BIN_DIR)/ukui-screensaver-command

install-i18n:
	# Install i18n
	$(MAKE) -C $(I18N_SRC) install

install-data:
	# Install gsettings file
	install -D data/org.ukui.screensaver.gschema.xml $(DESTDIR)$(GSETTINGS_DIR)/org.ukui.screensaver.gschema.xml

#
# Uninstallation
#

uninstall: uninstall-gui uninstall-i18n uninstall-data

uninstall-gui:
	# Uninstall GUI and scripts
	rm -rf $(DESTDIR)$(BIN_DIR)/ukui-screensaver
	rm -rf $(DESTDIR)$(BIN_DIR)/ukui-screensaver-command

uninstall-i18n:
	# Uninstall i18n
	$(MAKE) -C $(I18N_SRC) uninstall

uninstall-data:
	# Uninstall data
	rm -rf $(DESTDIR)$(GSETTINGS_DIR)/org.ukui.screensaver.gschema.xml

#
# Clean intermediate file
#

clean:
	# Clean GUI intermediate files
	rm -f *.o moc_* ui_*
	rm -f QtMakefile .qmake.stash ukui-screensaver ukui-screensaver-command
	# Clean i18n intermediate files
	$(MAKE) -C $(I18N_SRC) clean
