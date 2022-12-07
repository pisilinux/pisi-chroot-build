#!/bin/bash

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }

menu_option_one() {
  echo "Creating Docker Image"
  sudo python dockertest.py rootfs
}

menu_option_two() {
  echo "Tagging docker image"
  sudo docker tag pisichrootbeta:latest pisilinux/chroot:base
}

menu_option_three() {
  echo "Building docker image"
  sudo docker build . -t pisilinux/chroot:latest
}

menu_option_four() {
  echo "Connecting Hub-Docker Server"
  sudo chmod 666 /var/run/docker.sock
  docker login
}

menu_option_five() {
  echo "Committing chroot:base"
  docker push pisilinux/chroot:base
}

menu_option_six() {
  echo "Committing chroot:latest"
  docker push pisilinux/chroot:latest
}

press_enter() {
  echo ""
  echo -n "	Press Enter to continue "
  read
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo " "
  echo "      $(greenprint 'PISI GNU/LINUX DOCKER IMAGE CREATER')"
  echo " "
  echo "    	$(magentaprint '1  -  Create Docker Image')"
  echo "    	$(magentaprint '2  -  Tag Docker Image')"
  echo "    	$(magentaprint '3  -  Build Docker Image')"
  echo "    	$(magentaprint '4  -  Connect to Hub-Docker')"
  echo "    	$(magentaprint '5  -  Commit Base')"
  echo "    	$(magentaprint '6  -  Commit Latest')"
  echo "    	$(magentaprint '0  -  Exit')"
  echo " "
  echo "$(redprint '******************************************************************')"
  echo " "
  echo "                      WARNING!"
  echo "This application for the only Pisi GNU/Linux developers."
  echo "             It may damage your system."
  echo " "
  echo "$(redprint '******************************************************************')"
  echo " "
  echo -n "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; menu_option_one ; press_enter ;;
    2 ) clear ; menu_option_two ; press_enter ;;
    3 ) clear ; menu_option_three ; press_enter ;;
    4 ) clear ; menu_option_four ; press_enter ;;
    5 ) clear ; menu_option_five ; press_enter ;;
    6 ) clear ; menu_option_six ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
