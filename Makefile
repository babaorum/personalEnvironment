CURRENT_DIR = $(shell pwd)
LINUX_PATH  = '~/.config/sublime-text-3'
MAC_PATH    = '~/Library/Application\ Support/Sublime\ Text\ 3'

all: install

install: linuxInstall

linuxInstall: linuxSublimeInstall linuxPackageControlInstall linuxSublimeSettings

macInstall: macSublimeInstall macPackageControlInstall macSublimeSettings

sublime-phpcsTools: phpcs phpmd phpcsfixer

packageConfig:
	cp phpcs.sublime-settings $(LINUX_PATH)/Packages/User/phpcs.sublime-settings
	cp Markdown.sublime-settings $(LINUX_PATH)/Packages/User/Markdown.sublime-settings

# Linux installation part
linuxSublimeInstall:
	# Linux way
	wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb -O ./sublime-text-3.deb
	sudo dpkg -i sublime-text-3.deb
	rm sublime-text-3.deb

linuxPackageControlInstall:
	wget https://sublime.wbond.net/Package%20Control.sublime-package -O $(LINUX_PATH)/Installed\ Packages/Package\ Control.sublime-package
	cp $(CURRENT_DIR)/Package\ Control.sublime-settings $(LINUX_PATH)/Packages/User/Package\ Control.sublime-settings

linuxSublimeSettings:
	rm $(LINUX_PATH)/Packages/User/Preferences.sublime-settings
	cp $(CURRENT_DIR)/Preferences.sublime-settings $(LINUX_PATH)/Packages/User/Preferences.sublime-settings

# Mac installation part
macSublimeInstall:
	brew tap caskroom/versions
	brew cask install sublime-text3
	ln -s  "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

macPackageControlInstall:
	wget https://sublime.wbond.net/Package%20Control.sublime-package -O $(MAC_PATH)/Installed\ Packages/Package\ Control.sublime-package
	cp $(CURRENT_DIR)/Package\ Control.sublime-settings $(MAC_PATH)/Packages/User/Package\ Control.sublime-settings

macSublimeSettings:
	rm $(MAC_PATH)/Packages/User/Preferences.sublime-settings
	cp $(CURRENT_DIR)/Preferences.sublime-settings $(MAC_PATH)/Packages/User/Preferences.sublime-settings

# Sublime-phpcs installation part
phpcs:
	sudo apt-get install -y php-codesniffer

phpmd:
	wget http://static.phpmd.org/php/latest/phpmd.phar
	sudo chmod +x phpmd.phar && sudo mv phpmd.phar /usr/local/bin/phpmd

phpcsfixer:
	wget http://get.sensiolabs.org/php-cs-fixer.phar
	sudo chmod +x php-cs-fixer.phar && mv php-cs-fixer.phar /usr/local/bin/php-cs-fixer
