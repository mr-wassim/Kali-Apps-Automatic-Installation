#!/bin/bash
# -------------------------------------------------------
# Start

#########################################################
#                     en0x KAAIS v3                     #
#    Kali Applications Automatic Installation Script    #
#########################################################
#    DO-FIRST  : sudo chmod +x kaaisv3.sh               #
#                (Give EXEC Access To Script)           #
#    TO RUN    : ./kaaisv3.sh                           #
#########################################################

# Variables
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'
version="20141122"
spath="$( cd "$( dirname $0 )" && pwd )"

# KAAIS Logo
function showlogo {
  clear
  echo -e "${b}${g}
    :::    :::     :::         :::     :::::::  ::::::::
    :+:   :+:    :+: :+:     :+: :+:     :+:   :+:    :+:
    +:+  +:+    +:+   +:+   +:+   +:+    +:+   +:+
    +#++:++    +#++:++#++: +#++:++#++:   +#+   +#++:++#++
    +#+  +#+   +#+     +#+ +#+     +#+   +#+          +#+
    #+#   #+#  #+#     #+# #+#     #+#   #+#   #+#    #+#
    ###    ### ###     ### ###     ### #######  ##{v3}##${enda}
     ${c}Kali  Applications  Automatic  Installation  Script${endc}
       ${r}Team: en0xCr3w${endc}    ${b}${w}OpenSource${enda}    ${r}Code: rawstring${endc}"
    echo
}

# ROOT User Check
function checkroot {
  if [[ $(id -u) = 0 ]]; then
    echo -e " Checking For ROOT: ${g}PASSED${endc}"
  else
    echo -e " Checking For ROOT: ${r}FAILED${endc}
 ${y}This Script Needs To Run As ROOT${endc}"
    echo -e " ${b}KAAIS${enda} Will Now Exit"
    echo && sleep 2
    kexit
  fi
}

# Internet Check
function checkinternet {
  xterm -e ping -c 1 google.com > /dev/null
  if [[ "$?" != 0 ]]
  then
    echo -e " Checking For Internet: ${r}FAILED${endc}
 ${y}This Script Needs An Active Internet Connection${endc}"
    echo -e " ${b}KAAIS${enda} Will Now Exit"
    echo && sleep 2
    kexit
  else
    echo -e " Checking For Internet: ${g}PASSED${endc}"
  fi
}

# Initial Apt-Get Update
function initaptgetupd {
  echo && echo -e " ${y}Preparing To Perform Apt-Get Update${endc}"
  echo " It Is Recommended To Perform Apt-Get Update"
  echo " Before You Install Any Application."
  echo -en " ${y}Would You Like To Perform Apt-Get Update Now ? {y/n}${endc} "
  read option
  case $option in
    y) echo; echo " Performing Apt-Get Update"; xterm -e apt-get -y update; echo " Apt-Get Update Completed"; sleep 1 ;;
    n) echo " Skiping Apt-Get Update"; sleep 1 ;;
    *) echo " \"$option\" Is Not A Valid Option"; sleep 1; initaptgetupd ;;
  esac
}

# New Version Check & Update
function krestart {
  $spath/kaaisv3.sh
  exit
}
function kupdate {
  showlogo
  echo -e " Preparing To Update ${b}KAAIS${enda}"
  echo && echo -en " ${y}Press ENTER To Continue${endc}"
  read input
  echo && echo -e " ${b}Updating KAAIS, Please Wait${enda}"
  xterm -e wget http://sourceforge.net/projects/kaais/files/kaaisv3.sh -O $spath/kaaisv3.sh
  echo -e " ${g}KAAIS Was Successfully Updated${endc}"
  echo -e " Restarting KAAIS..."
  sleep 1
  krestart
}
function kcheck {
  changelog=$(curl --silent -q http://kaais.uboxi.com/changelog.txt)
  last_version=$(curl --silent -q http://kaais.uboxi.com/version.txt)
  if [[ $last_version > $version ]]; then
    echo -e " Checking For Update: ${r}New Version Available${endc}"
    echo -e " ${bu}Changelog:${enda}
 $changelog"
    echo && echo -en " ${y}Do You Want To Update? {y/n}${endc} "
    read option
    case $option in
      y) kupdate ;;
      n) echo -e " ${y}Ok, Not Updating.${endc}"; sleep 1; initaptgetupd ;;
      *) echo " \"$option\" Is Not A Valid Option"; sleep 1; kcheck ;;
    esac
  else
    echo -e " Checking for update: ${g}Updated${endc}"
    sleep 1
  fi
}

# Script Initiation
showlogo && echo -e " ${y}Preparing To Run Script${endc}" && sleep 1
checkroot && checkinternet && kcheck && initaptgetupd && sleep 1

# Install Emacs
function installemacs {
  echo
  echo -e " Currently Installing ${b}Emacs${enda}"
  echo -e " ${bu}GNU Emacs is an extensible, customizable text editor—and
 more. At its core is an interpreter for Emacs Lisp,
 a dialect of the Lisp programming language with
 extensions to support text editing.
 Read more about it here: ${b}http://www.gnu.org/software/emacs/${endc}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Emacs${enda}"
  xterm -e apt-get -y install emacs
  echo -e " ${b}Emacs${enda} Was Successfully Installed"
  echo && echo " Run Emacs From ${b}Programming${endc}"
  echo -en " ${y}Press Enter To Return To Menu${endc}"
  echo
  read input
}

# Install Joe
function installjoe {
  showlogo
  echo -e " ${y}Preparing To Install Joe${endc}" && echo
  echo -e " ${bu}JOE is a full featured terminal-based screen editor
 which is distributed under the GNU General Public License (GPL).
 JOE has been around since 1988 and comes standard with many
 Linux distributions.
 Read more about it here: ${b}http://joe-editor.sourceforge.net/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Joe${enda}"
  xterm -e apt-get -y install joe
  echo -e " ${b}Joe${enda} Was Successfully Installed"
  echo && echo -e " Run Joe From The Terminal: ${b}joe${endc}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install GEdit
function installgedit {
  showlogo
  echo -e " ${y}Preparing To Install GEdit${endc}" && echo
  echo -e " ${bu}GEdit is a text editor for the GNOME desktop environment,
 Mac OS X and Microsoft Windows. Designed as a general purpose
 text editor, GEdit emphasizes simplicity and ease of use.
 It includes tools for editing source code and structured
 text such as markup languages.
 Read more about it here: ${b}https://projects.gnome.org/gedit/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}GEdit${enda}"
  xterm -e apt-get -y install gedit
  echo -e " ${b}GEdit${enda} Was Successfully Installed"
  echo && echo -e "Run GEdit From The ${b}Accessories${endc} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install Geany
function installgeany {
  showlogo
  echo -e " ${y}Preparing To Install Geany${endc}" && echo    
  echo -e " ${bu}Geany is a text editor using the GTK2 toolkit with
 basic features of an integrated development environment.
 It was developed to provide a small and fast IDE, which has
 only a few dependencies from other packages. It supports
 many filetypes and has some nice features.
 Read more about it here: ${b}http://www.geany.org/Main/About/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Geany${enda}"
  xterm -e apt-get -y install geany
  echo -e " ${b}Geany${enda} Was Successfully Installed"
  echo && echo -e " Run Geany From The ${b}Programming${endc} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install FileZilla
function installfilez {
  showlogo
  echo -e " Preparing To Install ${b}FileZilla${enda}" && echo
  echo -e " ${bu}FileZilla Client is a free, open source FTP client. It supports
 FTP, SFTP, and FTPS (FTP over SSL/TLS). The client is
 available under many platforms, binaries for Windows, Linux
 and Mac OS X are provided.
 Read more about it here: ${b}https://filezilla-project.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}FileZilla${enda}"
  xterm -e apt-get -y install filezilla
  echo -e " ${b}FileZilla${enda} Was Successfully Installed"
  echo && echo -e " Run FileZilla From The ${b}Internet${endc} Menu"
  echo && echo -en " ${y}Press  Enter To Return To Menu${endc}" && echo
  read input
}

# Install gFTP
function installgftp {
  showlogo
  echo -e " Preparing To Install ${b}gFTP${enda}" && echo
  echo -e " ${bu}gFTP is a free/open source multithreaded FTP client. It is
 most used on Unix-like systems, such as Linux, Mac OS X and
 Sony PlayStation 3. There is support for the FTP, FTPS (control
 connection only), HTTP, HTTPS, SFTP and FSP protocols, as well
 as FTP and HTTP proxy server support and FXP file transfers
 (transferring files between 2 remote servers via FTP).
 Read more about it here: ${b}http://gftp.seul.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}gFTP${enda}"
  xterm -e apt-get -y install gftp
  echo -e " ${b}gFTP${enda} Was Successfully Installed"
  echo && echo -e " Run gFTP From The ${b}Internet${endc} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install KFTPGrabber
function installkftpg {
  showlogo
  echo -e " Preparing To Install ${b}KFTPGrabber${enda}" && echo
  echo -e " ${bu}KFTPGrabber is a KDE FTP client. It supports SSL/TLS connections
 to secure FTP sites, OTP passwords and FXP transfers. It also
 has transfer queuing support, and many more features.
 Read more about it here: ${b}http://extragear.kde.org/apps/kftpgrabber/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}KFTPGrabber${endc}"
  xterm -e apt-get -y install kftpgrabber
  echo -e " ${b}KFTPGrabber${enda} Was Successfully Installed"
  echo && echo -e " Run KFTPGrabber From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install Transmission
function installtransmission {
  showlogo
  echo -e " Preparing To Install ${b}Transmission${enda}" && echo
  echo -e " ${bu}Transmission is designed for easy, powerful use. We've set the
 defaults to Just Work and it only takes a few clicks to
 configure advanced features like watch directories,
 bad peer blocklists, and the web interface.
 Read more about it here: ${b}http://www.transmissionbt.com/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Transmission${endc}"
  xterm -e apt-get -y install transmission
  echo -e " ${b}Transmission${enda} Was Successfully Installed"
  echo && echo -e " Run Transmission From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}" && echo
  read input
}

# Install xChat
function installxchat {
  showlogo
  echo -e " Preparing To Install ${b}xChat${enda}" && echo
  echo -e " ${bu}XChat is an IRC chat program for both Linux and Windows.
 It allows you to join multiple IRC channels (chat rooms)
 at the same time, talk publicly, private one-on-one conversations
 etc.. Even file transfers are possible. 
 Read more about it here: ${b}http://xchat.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}xChat${enda}"
  xterm -e apt-get -y install xchat
  echo -e " ${b}xChat${enda} Was Successfully Installed"
  echo && echo -e " Run xChat From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Pinta
function installpinta {
  showlogo
  echo -e " Preparing To Install ${b}Pinta${enda}" && echo
  echo -e " ${bu}Pinta is a free, open source drawing/editing program
 modeled after Paint.NET. Its goal is to provide users
 with a simple yet powerful way to draw and manipulate
 images on Linux, Mac, and Windows. 
 Read more about it here: ${b}http://pinta-project.com/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Pinta${enda}"
  xterm -e apt-get -y install pinta
  echo -e " ${b}Pinta${enda} Was Successfully Installed"
  echo && echo -e " Run Pinta From The ${b}Graphics${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install GIMP
function installgimp {
  showlogo
  echo -e " Preparing To Install ${b}GIMP${enda}" && echo
  echo -e " ${bu}GIMP is the GNU Image Manipulation Program. It is a freely
 distributed piece of software for such tasks as photo
 retouching, image composition and image authoring. It
 works on many operating systems, in many languages. 
 Read more about it here: ${b}http://www.gimp.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}GIMP${enda}"
  xterm -e apt-get -y install gimp
  echo -e " ${b}GIMP${enda} Was Successfully Installed"
  echo && echo -e " Run GIMP From The ${b}Graphics${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Inkscape
function installinkscape {
  showlogo
  echo -e " Preparing To Install ${b}Inkscape${enda}" && echo
  echo -e " ${bu}An Open Source vector graphics editor, with capabilities
 similar to Illustrator, CorelDraw, or Xara X, using the
 W3C standard Scalable Vector Graphics (SVG) file format.
 Inkscape supports many advanced SVG features (markers,
 clones, alpha blending, etc.) and great care is taken in
 designing a streamlined interface. It is very easy to edit
 nodes, perform complex path operations, trace bitmaps and
 much more. 
 Read more about it here: ${b}http://inkscape.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Inkscape${enda}"
  xterm -e apt-get -y install inkscape
  echo -e " ${b}Inkscape${enda} Was Successfully Installed"
  echo && echo -e " Run Inkscape From The ${b}Graphics${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install
function installark {
  showlogo
  echo -e " Preparing To Install ${b}Ark${enda}" && echo
  echo -e " ${bu}Ark is a program for managing various archive formats
 (RAR, ZIP, ...) within the KDE environment. Archives can
 be viewed, extracted, created and modified from within Ark. The
 program can handle various formats such as tar, gzip, bzip2,
 zip, rar and lha (if appropriate command-line programs are
 installed). Ark can work closely with Konqueror in the  KDE
 environment to handle archives, if you install the Konqueror
 Integration plugin available in the kdeaddons package.
 Read more about it here: ${b}http://utils.kde.org/projects/ark/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Ark${enda}"
  xterm -e apt-get -y install ark
  echo -e " ${b}Ark${enda} Was Successfully Installed"
  echo && echo -e " Run Ark From The Terminal: ${b}ark${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install
function installfileroller {
  showlogo
  echo -e " Preparing To Install ${b}File-Roller${enda}" && echo
  echo -e " ${bu}File Roller is the archive manager of the GNOME desktop
 environment.
 Read more about it here: ${b}http://fileroller.sourceforge.net/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}File-Roller${enda}"
  xterm -e apt-get -y unrar unace rar unrar p7zip zip unzip p7zip-full p7zip-rar file-roller
  echo -e " ${b}File-Roller${enda} Was Successfully Installed"
  echo && echo -e " Run File-Roller From The ${b}Accessories${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Zip/Unzip
function installzipunzip {
  showlogo
  echo -e " Preparing To Install ${b}Zip/Unzip${enda}" && echo
  echo -e " ${bu}unzip will list, test, create, or extract files from/to
 a ZIP archive, commonly found on MS-DOS systems. both
 programs are compatible with archives created by PKWARE's
 PKZIP and PKUNZIP for MS-DOS, but in many cases the program
 options or default behaviors differ.
 Read more about Zip: ${b}http://linux.about.com/od/commands/l/blcmdl1_zip.htm${enda}
 ${bu}Read more about Unzip: ${b}http://linux.about.com/od/commands/l/blcmdl1_unzip.htm${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Zip/Unzip${enda}"
  xterm -e apt-get -y install zip unzip
  echo -e " ${b}Zip/Unzip${enda} Was Successfully Installed"
  echo && echo -e " Run Zip/Unzip From The Terminal: ${b}zip${enda} or ${b}unzip${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Rar/Unrar
function installrarunrar {
  showlogo
  echo -e " Preparing To Install ${b}Rar/Unrar${enda}" && echo
  echo -e " ${bu}Rar and Unrar commands allows you to compress or uncompress
 one or more files on the Terminal.
 Read more about Rar/Unrar: ${b}http://linux.101hacks.com/unix/rar-command-examples/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Rar/Unrar${enda}"
  xterm -e apt-get -y install rar unrar
  echo -e " ${b}Rar/Unrar${enda} Was Successfully Installed"
  echo && echo -e " Run Rar/Unrar From The Terminal: ${b}rar${enda} or ${b}unrar${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Audacious
function installaudacious {
  showlogo
  echo -e " Preparing To Install ${b}Audacious${enda}" && echo
  echo -e " ${bu}Audacious is an open source audio player. A descendant of XMMS,
 Audacious plays your music how you want it, without
 stealing away your computer’s resources from other
 tasks. Drag and drop folders and individual song files,
 search for artists and albums in your entire music library,
 or create and edit your own custom playlists. Listen to CD’s
 or stream music from the Internet. Tweak the sound with the
 graphical equalizer or experiment with LADSPA effects. Enjoy
 the modern GTK-themed interface or change things up with
 Winamp Classic skins. Use the plugins included with Audacious
 to fetch lyrics for your music, to set an alarm in the morning, and more.
 Read more about it here: ${b}http://audacious-media-player.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Audacious${enda}"
  xterm -e apt-get -y install audacious
  echo -e " ${b}Audacious${enda} Was Successfully Installed"
  echo && echo -e " Run Audacious From The ${b}Sound & Video${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Amarok
function installamarok {
  showlogo
  echo -e " Preparing To Install ${b}Amarok${enda}" && echo
  echo -e " ${bu}Amarok is a powerful music player for Linux, Unix and
 Windows with an intuitive interface. It makes playing
 the music you love and discovering new music easier than
 ever before - and it looks good doing it.
 Read more about it here: ${b}http://amarok.kde.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Amarok${enda}"
  xterm -e apt-get -y install amarok
  echo -e " ${b}Amarok${enda} Was Successfully Installed"
  echo && echo -e " Run Amarok From The ${b}Sound & Audio${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Banshee
function installbanshee {
  showlogo
  echo -e " Preparing To Install ${b}Banshee${enda}" && echo
  echo -e " ${bu}Banshee is maintained by Aaron Bockover, Andres G. Aragoneses,
 Alexander Kojevnikov, Bertrand Lorentz, and Gabriel Burt.
 Over 155 developers, 130 translators, 6 artists, and
 countless users and volunteers have contributed to Banshee.
 Read more about it here: ${b}http://banshee.fm/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Banshee${enda}"
  xterm -e apt-get -y install banshee
  echo -e " ${b}Banshee${enda} Was Successfully Installed"
  echo && echo -e " Run Banshee From The ${b}Sound & Audio${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Sonata
function installsonata {
  showlogo
  echo -e " Preparing To Install ${b}Sonata${enda}" && echo
  echo -e " ${bu}Sonata is an elegant GTK+ music client for the Music Player
 Daemon (MPD). The latest version is 1.6.2.1.
 Read more about it here: ${b}http://sonata.berlios.de/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Sonata${enda}"
  xterm -e apt-get -y install sonata
  echo -e " ${b}Sonata${enda} Was Successfully Installed"
  echo && echo -e " Run Sonata From The ${b}Sound & Video${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Audacity
function installaudacity {
  showlogo
  echo -e " Preparing To Install ${b}Audacity${enda}" && echo
  echo -e " ${bu}Audacity is a free, easy-to-use, multi-track audio editor
 and recorder for Windows, Mac OS X, GNU/Linux and other
 operating systems. The interface is translated into many
 languages. And much more..
 Read more about it here: ${b}http://audacity.sourceforge.net/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Audacity${enda}"
  xterm -e apt-get -y install audacity
  echo -e " ${b}Audacity${enda} Was Successfully Installed"
  echo && echo -e " Run Audacity From The ${b}Sound & Audio${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Ardour
function installardour {
  showlogo
  echo -e " Preparing To Install ${b}Ardour${enda}" && echo
  echo -e " ${bu}Ardour is a hard disk recorder and digital audio workstation
 application. It runs on Linux, OS X and FreeBSD. Its
 primary author is Paul Davis, who is also responsible
 for the JACK Audio Connection Kit. Ardour's intention
 is to provide digital audio workstation software suitable
 for professional use.
 Read more about it here: ${b}http://ardour.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Ardour${enda}"
  xterm -e apt-get -y install ardour
  echo -e " ${b}Ardour${enda} Was Successfully Installed"
  echo && echo -e " Run Ardour From The ${b}Sound & Audio${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Sweep
function installsweep {
  showlogo
  echo -e " Preparing To Install ${b}Sweep${enda}" && echo
  echo -e " ${bu}Sweep is a digital audio editor and live playback tool for
 Linux, BSD and compatible systems. It is able to handle
 many sound formats, including MP3, WAV, AIFF, Ogg Vorbis,
 Speex and Vorbis. Originally developed with the support
 of Pixar, the most notable feature of Sweep is its stylus-like
 cursor tool called Scrubby.
 Read more about it here: ${b}http://www.metadecks.org/software/sweep/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Sweep${enda}"
  xterm -e apt-get -y install sweep
  echo -e " ${b}Sweep${enda} Was Successfully Installed"
  echo && echo -e " Run Sweep From The ${b}Sound & Audio${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Chromium
function installchromium {
  getggrep="/etc/apt/sources.list.d/google.list"
  showlogo
  echo -e " Preparing To Install ${b}Chromium${enda}" && echo
  echo -e " ${bu}Chromium is an open-source browser project that aims to build
 a safer, faster, and more stable way for all Internet
 users to experience the web. This site contains design
 documents, architecture overviews, testing information,
 and more to help you learn to build and work with the
 Chromium source code.
 Read more about it here: ${b}http://www.chromium.org/Home${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Chromium${enda}"
  if [[ -d $getggrep ]]; then
    echo -e " ${b}Google Linux Repository${enda} status: ${g}Installed${endc}"
    xterm -e apt-get install chromium
    xterm -e wget http://sourceforge.net/projects/kaais/files/Custom_Files/chromium -O /usr/bin/chromium
  else
    echo -e " ${b}Google Linux Repository${enda} status: ${r}Not Found${endc}"
    echo -e " Installing ${b}Google Linux Repository${enda}"
      xterm -e "wget -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -"
      xterm -e sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
      xterm -e apt-get update
    echo -e " ${b}Google Linux Repository${enda} is now installed"
    xterm -e apt-get install chromium
    xterm -e wget http://sourceforge.net/projects/kaais/files/Custom_Files/chromium -O /usr/bin/chromium
  fi
  echo -e " ${b}Chromium${enda} Was Successfully Installed"
  echo && echo -e " Run Chromium From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Google Chrome
function installchrome {
  getggrep="/etc/apt/sources.list.d/google.list"
  showlogo
  echo -e " Preparing To Install ${b}Chrome${enda}" && echo
  echo -e " ${bu}Google Chrome is a freeware web browser developed by Google.
 It used the WebKit layout engine until version 27 and,
 with the exception of its iOS releases, from version 28
 and beyond uses the WebKit fork Blink.
 Read more about it here: ${b}https://www.google.com/chrome/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Chrome${enda}"
  if [[ -d $getggrep ]]; then
    echo -e " ${b}Google Linux Repository${enda} status: ${g}Installed${endc}"
    xterm -e apt-get -y install google-chrome-stable
    xterm -e wget http://sourceforge.net/projects/kaais/files/Custom_Files/google-chrome -O /opt/google/chrome/google-chrome
  else
    echo -e " ${b}Google Linux Repository${enda} status: ${r}Not Found${endc}"
    echo -e " Installing ${b}Google Linux Repository${enda}"
      xterm -e "wget -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -"
      xterm -e sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
      xterm -e apt-get update
    echo -e " ${b}Google Linux Repository${enda} is now installed"
    xterm -e apt-get -y install google-chrome-stable
    xterm -e wget http://sourceforge.net/projects/kaais/files/Custom_Files/google-chrome -O /opt/google/chrome/google-chrome
  fi
  echo -e " ${b}Chrome${enda} Was Successfully Installed"
  echo && echo -e " Run Chrome From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Youtube Downloader
function installytbdwn {
  showlogo
  echo -e " Preparing To Install ${b}Youtube Downloader${enda}" && echo
  echo -e " ${bu}Simple Youtube Video Downloader, used from Terminal on
 any Linux distribution. Frequently updated.
 Read more about it here: ${b}https://yt-dl.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Youtube Downloader${enda}"
  xterm -e wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl
  echo -e " ${b}Youtube Downloader${enda} Was Successfully Installed"
  xterm -e chmod a+x /usr/local/bin/youtube-dl
  echo -e " All ${b}Youtube Downloader${enda} Files Were Flaged For Execute Successfully"
  echo && echo -e " Run Youtube Downloader From The Terminal: ${b}youtube-dl \"http://youtube.com/watch?v=XXXXXXX${enda}\" "
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Netool.sh
function installnetool {
  showlogo
  echo -e " Preparing To Install ${b}Netool.sh${enda}" && echo
  echo -e " ${bu}Netool.sh its a script in bash to automate frameworks
  like Metasploit, Nmap, Driftnet, SSLstrip, Ettercap,
  macchanger, webcrawler. This script makes it easy
  tasks such as SNIFFING, MITM, SSLsniff, Dns-spoofing,
  retrieve metadata, and DoS attacks inside the external/local
  network can also perform TCP/UDP packets manipulation
  using ettercap filters, search for target geolocation,
  the 'webcrawler.py' can search for admin login page,
  website directorys, webshells.php planted on website,
  common file upload vulns scanner (LFI), search forXSS
  vuln websites, and a colection of (metasploit) automated
  exploits ...
 Read more about it here: ${b}http://netoolsh.sourceforge.net/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Netool.sh${enda}"
  xterm -e wget -P /root/ http://sourceforge.net/projects/netoolsh/files/opensource%5Bkali%5D.tar.gz
  xterm -e tar -xvf /root/opensource[kali].tar.gz -C /root/
  xterm -e rm /root/opensource[kali].tar.gz 
  echo -e " ${b}Netool.sh${enda} Was Successfully Installed"
  xterm -e chmod +x /root/opensource/*.sh
  xterm -e chmod +x /root/opensource/*.py
  xterm -e chmod +x /root/opensource/sslstrip-0.9/*.py
  echo -e " All ${b}Netool.sh${enda} Files Were Flaged For Execute Successfully"
  echo && echo -e " Run Netool.sh From The Terminal: ${b}./netool.sh${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Skype
function installskype {
  showlogo
  echo -e " Preparing To Install ${b}Skype${enda}" && echo
  echo -e " ${bu}Skype is a freemium voice-over-IP service and
 instant messaging client that is currently developed
 by the Microsoft Skype Division. The name originally
 derived from \"sky\" and \"peer\".
 Read more about it here: ${b}http://www.skype.com/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Skype${enda}"
  xterm -e wget -P /root/ http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb
  xterm -e dpkg -i /root/skype-debian_4.3.0.37-1_i386.deb
  xterm -e rm /root/skype-debian_4.3.0.37-1_i386.deb 
  echo -e " ${b}Skype${enda} Was Successfully Installed"
  echo && echo -e " Run Skype From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Teamviewer
function installteamviewer {
  showlogo
  echo -e " Preparing To Install ${b}Teamviewer${enda}" && echo
  echo -e " ${bu}TeamViewer is a proprietary computer software package for
 remote control, desktop sharing, online meetings, web
 conferencing and file transfer between computers. The
 software operates with the Microsoft Windows, OS X, Linux,
 iOS, Android, Windows RT and Windows Phone operating
 systems. It is also possible to access a machine running
 TeamViewer with a web browser. While the main focus of
 the application is remote control of computers, collaboration
 and presentation features are included.
 Read more about it here: ${b}http://www.teamviewer.com/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Teamviewer${enda}"
  xterm -e wget -P /root/ http://download.teamviewer.com/download/teamviewer_linux.deb
  xterm -e dpkg -i /root/teamviewer_linux.deb
  xterm -e rm /root/teamviewer_linux.deb
  echo -e " ${b}Teamviewer${enda} Was Successfully Installed"
  echo && echo -e " Run Teamviewer From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Update Iceweasel
function installiceweasel {
  showlogo
  echo -e " Preparing To Update ${b}Iceweasel${enda}" && echo
  echo -e " ${b}${r}ATTENTION:${enda} ${bu}You need to close all your Iceweasel
 instances in order for the update to succeed."
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Updating ${b}Iceweasel${enda}"
  xterm -e apt-get -y install iceweasel
  echo -e " ${b}Iceweasel${enda} Was Successfully Updated"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Update Adobe Flash Player
function installflashplugin {
  showlogo
  echo -e " Preparing To Update ${b}Adobe Flash Player${enda}" && echo
  echo -e " ${b}${r}ATTENTION:${enda} ${bu}You need to close all your Iceweasel
 instances in order for the update to succeed."
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Updating ${b}Adobe Flash Player${enda}"
  xterm -e apt-get -y install flashplugin-nonfree
  xterm -e update-flashplugin-nonfree --install
  echo -e " ${b}Adobe Flash Player${enda} Was Successfully Updated"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Update Joomscan
function installjoomscan {
  showlogo
  echo -e " Preparing To Update ${b}Joomscan${enda}" && echo
  echo -e " ${bu}Detects file inclusion, sql injection, command execution
 vulnerabilities of a target Joomla! web site.
 We'll update it soon. The database update is
 currently maintained by web-center.si.
 Read more about it here: ${b}https://sourceforge.net/projects/joomscan/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Updating ${b}Joomscan${enda}"
  xterm -e joomscan update
  echo -e " ${b}Joomscan${enda} Was Successfully Updated"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Sources.list
function installsources {
  showlogo
  echo -e " Preparing To Update ${b}sources.list${enda}" && echo
  echo -e " ${bu}As part of its operation, Apt uses a file that lists the
 'sources' from which packages can be obtained.
 Read more about it here: ${b}http://docs.kali.org/general-use/kali-linux-sources-list-repositories${enda}"
  echo -e " ${r}ATTENTION:${endc} This 'sources.list' file was
 modified by me (rawstring) and it is the one
 I actually use. But still, it is not an official
 release, so use/modify it at your own risk."
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Updating ${b}sources.list${enda}"
  xterm -e mv /etc/apt/sources.list /etc/apt/sources.list.backup
  echo -e " Creating File Backup: ${g}OK${endc}"
  xterm -e wget http://sourceforge.net/projects/kaais/files/Custom_Files/sources.list -O /etc/apt/sources.list
  echo -e " ${b}sources.list${enda} Was Successfully Updated"
  echo -e " Performing ${b}apt-get update${enda}"
  xterm -e apt-get -y update
  echo && echo -e " ${b}apt-get update${enda} Completed"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Terminator
function installterminator {
  showlogo
  echo -e " Preparing To Install ${b}Terminator${enda}" && echo
  echo -e " ${bu}Originally created and developed for a long time by Chris Jones,
 the goal of this project is to produce a useful tool for
 arranging terminals. It is inspired by programs such as
 gnome-multi-term, quadkonsole, etc. in that the main focus
 is arranging terminals in grids (tabs is the most common
 default method, which Terminator also supports).
 Read more about it here: ${b}http://gnometerminator.blogspot.pt/p/introduction.html${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Terminator${enda}"
  xterm -e apt-get -y install terminator
  echo -e " ${b}Terminator${enda} Was Successfully Installed"
  echo && echo -e " Run Terminator From The ${b}Accessories${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Gnome Tweak Tool
function installgnometweaktool {
  showlogo
  echo -e " Preparing To Install ${b}Gnome Tweak Tool${enda}" && echo
  echo -e " ${bu}A tool to customize advanced GNOME 3 options.
 Read more about it here: ${b}https://wiki.gnome.org/GnomeTweakTool${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Gnome Tweak Tool${enda}"
  xterm -e apt-get -y install gnome-tweak-tool
  echo -e " ${b}Gnome Tweak Tool${enda} Was Successfully Installed"
  echo && echo -e " Run Gnome Tweak Tool From The Terminal: ${b}gnome-tweak-tool${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Add/Remove Google Linux Repository
function installaddglrepo {
  showlogo
  echo -e " Preparing To Add ${b}Google Linux Repository${enda}" && echo
  echo -e " ${bu}Adding Google's Linux Repository, will allow you to perform basic
 Google installations via 'APT-GET' commands.
 Read more about it here: ${b}http://www.google.com/linuxrepositories/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Adding ${b}Google Linux Repository${enda}"
  xterm -e "wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -"
  xterm -e sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  echo -e " ${b}Google Linux Repository${enda} Was Successfully Added"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

function installremglrepo {
  showlogo
  echo -e " Preparing To Remove ${b}Google Linux Repository${enda}" && echo
  echo -e " ${bu}Removing Google's Linux Repository, will make it impossible to
 install or remove any packages via 'ATP-GET' commands.
 Read more about it here: ${b}http://www.google.com/linuxrepositories/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Removing ${b}Google Linux Repository${enda}"
  xterm -e rm /etc/apt/sources.list.d/google*
  echo -e " ${b}Google Linux Repository${enda} Was Successfully Removed"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install WPScan (This Also Fixes The Rubygem Error)
function installwpscan {
  showlogo
  echo -e " Preparing To Install ${b}WPScan${enda}" && echo
  echo -e " ${bu}WPScan is a black box WordPress vulnerability scanner.
 Read more about it here: ${b}http://wpscan.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}WPScan${enda}"
  xterm -e apt-get -y install wpscan
  echo -e " ${b}WPScan${enda} Was Successfully Installed"
  echo -e " Updating ${b}WPScan${enda}"
  xterm -e wpscan --update
  echo -e " ${b}WPScan${enda} Was Successfully Updated"
  echo && echo -e " Run WPScan From The Terminal: ${b}wpscan${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Nmap & Zenmap
function installnmapzen {
  showlogo
  echo -e " Preparing To Install ${b}Nmap - Zenmap${enda}" && echo
  echo -e " ${bu}Nmap ("Network Mapper") is a free and open source (license)
 utility for network discovery and security auditing.
 Many systems and network administrators also find
 it useful for tasks such as network inventory,
 managing service upgrade schedules, and monitoring
 host or service uptime.
 Read more about it here: ${b}http://nmap.org/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Nmap - Zenmap${enda}"
  xterm -e apt-get -y install nmap zenmap
  echo -e " ${b}Nmap - Zenmap${enda} Was Successfully Installed"
  echo && echo -e " Run Nmap From The Terminal: ${b}nmap${enda} or ${b}zenmap${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Metasploit
function installmetasploit {
  showlogo
  echo -e " Preparing To Install ${b}Metasploit${enda}" && echo
  echo -e " ${bu}Metasploit Framework, a tool for developing and executing
 exploit code against a remote target machine.
 Other important sub-projects include the Opcode
 Database, shellcode archive and related research.
 Read more about it here: ${b}http://www.metasploit.com/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Metasploit${enda}"
  xterm -e msfupdate
  echo -e " ${b}Metasploit${enda} Was Successfully Installed"
  echo && echo -e " Run Metasploit From The Terminal: ${b}msfconsole${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Veil
function installveil {
  showlogo
  echo -e " Preparing To Install ${b}Veil${enda}" && echo
  echo -e " ${bu}Veil is an open source payload obfusctator with support
 for obfuscating shellcode and meterpreter payloads
 using a variety of different programming languages
 and methods.
 Read more about it here: ${b}https://www.veil-framework.com/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Veil${enda}"
  xterm -e apt-get -y install veil
  echo -e " ${b}Veil${enda} Was Successfully Installed"
  echo && echo -e " Run Veil From The Terminal: ${b}veil${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Hamachi
function installhamachi {
  showlogo
  echo -e " Preparing To Install ${b}Hamachi${enda}" && echo
  echo -e " ${bu}LogMeIn Hamachi is a hosted VPN service that lets you
 securely extend LAN-like networks to distributed
 teams, mobile workers and your gamer friends alike
 in a few minutes.
 Read more about it here: ${b}https://secure.logmein.com/products/hamachi/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Hamachi${enda}"
  xterm -e wget -P /root/ https://secure.logmein.com/labs/logmein-hamachi_2.1.0.119-1_i386.deb
  xterm -e dpkg -i /root/logmein-hamachi_2.1.0.119-1_i386.deb
  xterm -e apt-get -yf install
  xterm -e dpkg -i /root/logmein-hamachi_2.1.0.119-1_i386.deb
  xterm -e rm /root/logmein-hamachi_2.1.0.119-1_i386.deb
  echo -e " ${b}Hamachi${enda} Was Successfully Installed"
  echo && echo -e " Run Hamachi From The Terminal: ${b}hamachi${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install Haguichi (GUI For Hamachi)
function installhaguichi {
  showlogo
  echo -e " Preparing To Install ${b}Haguichi${enda}" && echo
  echo -e " ${bu}Haguichi provides a graphical frontend for Hamachi on Linux.
 This step might take a little bit to complete,
 because it has to add a couple repositories and
 re-do 'apt-get update' before installing Haguichi.
 Read more about it here: ${b}http://www.haguichi.net/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}Haguichi${enda}"
  xterm -e cp /etc/apt/sources.list /etc/apt/sources.list.bck1
  xterm -e sudo sh -c 'echo "deb http://ppa.launchpad.net/webupd8team/haguichi/ubuntu precise main" >> /etc/apt/sources.list'
  xterm -e sudo sh -c 'echo "deb-src http://ppa.launchpad.net/webupd8team/haguichi/ubuntu precise main" >> /etc/apt/sources.list'
  xterm -e apt-get -y update
  xterm -e apt-get -y install haguichi
  xterm -e mv -f /etc/apt/sources.list.bck1 /etc/apt/sources.list
  echo -e " ${b}Haguichi${enda} Was Successfully Installed"
  echo && echo -e " Run Haguichi From The ${b}Internet${enda} Menu"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install thad0ctor's BT5 Toolkit
function installthad0ctor {
  showlogo
  echo -e " Preparing To Install ${b}thad0ctor's${enda}" && echo
  echo -e " ${bu}In short it is the ultimate tool for those looking to
 make a wide variety of word lists for dictionary
 based and other brute force attacks.
 Read more about it here: ${b}https://sourceforge.net/projects/thad0ctorstools/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}thad0ctor's${enda}"
  xterm -e wget -P /root/ http://freefr.dl.sourceforge.net/project/thad0ctorstools/backtrack%205%20toolkit/backtrack%205%20toolkit%20v1.4/thad0ctors%20Backtrack%205%20toolkit%20v1.4.zip
  xterm -e unzip /root/thad0ctors\ Backtrack\ 5\ toolkit\ v1.4.zip
  xterm -e rm /root/thad0ctors\ Backtrack\ 5\ toolkit\ v1.4.zip
  echo -e " ${b}thad0ctor's${enda} Was Successfully Installed"
  echo && echo -e " Run thad0ctor's From The Terminal: ${b}./thad0ctors\ Backtrack\ 5\ toolkit/LAUNCH_TOOLKIT.sh${enda}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install PHP-cURL
function installphpcurl {
  showlogo
  echo -e " Preparing To Update ${b}PHP-cURL${enda}" && echo
  echo -e " ${bu}PHP/CURL is a binding that uses libcurl. It means that
 the PHP team has written a glue layer for
 PHP that speaks to the underlying libcurl.
 That layer, the binding, is what we call
 PHP/CURL and that is what offers the functions
 named curl_* within the PHP language for you.
 Read more about it here: ${b}http://curl.haxx.se/libcurl/php/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Updating ${b}PHP-cURL${enda}"
  xterm -e apt-get -y install php5-curl
  echo -e " ${b}PHP-cURL${enda} Was Successfully Updated"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Install LOIC
function installloic {
  showlogo
  echo -e " Preparing To Install ${b}LOIC${enda}" && echo 
  echo -e " ${bu}Low Orbit Ion Cannon (LOIC) is an open source network
 stress testing and denial-of-service attack
 application, written in C#. LOIC was initially
 developed by Praetox Technologies, but was
 later released into the public domain, and now
 is hosted on several open source platforms.
 Read more about it here: ${b}https://sourceforge.net/projects/loic/${enda}"
  echo && echo -en " ${y}Press Enter To Continue${endc}"
  read input
  echo -e " Installing ${b}${enda}"
  xterm -e wget -P /root/loic/ https://raw.github.com/nicolargo/loicinstaller/master/loic.sh
  xterm -e apt-get -y install git-core monodevelop
  xterm -e chmod a+x /root/loic/loic.sh
  xterm -e ./root/loic/loic.sh install
  xterm -e ./root/loic/loic.sh update
  echo && echo -e " Run LOIC From The Terminal: ${b}./loic.sh run${enda}"
  echo -e " ${b}LOIC${enda} Was Successfully Installed"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Text Editors Menu
function showtext {
  showlogo
  echo -e " ${b}[ TEXT EDITORS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    GEdit
        2)    Geany
        3)    Emacs
        4)    Joe
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installgedit ;;
  2) installgeany ;;
  3) installemacs ;;
  4) installjoe ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showtext ;;
  esac
}

# Menu FTP Applications
function showftptorr {
  showlogo
  echo -e " ${b}[ FTP/TORRENT APPLICATIONS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    FileZilla (FTP Client)
        2)    gFTP
        3)    kFTPgrabber (For KDE)
        4)    Transmission (Torrent Client)
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installfilez ;;
  2) installgftp ;;
  3) installkftpg ;;
  4) installtransmission ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showftptorr ;;
  esac
}

# Menu Chat Applications
function showchat {
  showlogo
  echo -e " ${b}[ CHAT APPLICATIONS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    xChat
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installxchat ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showchat ;;
  esac
}

# Menu Image Editors
function showimg {
  showlogo
  echo -e " ${b}[ IMAGE EDITORS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Pinta
        2)    GIMP
        3)    Inkscape
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installpinta ;;
  2) installgimp ;;
  3) installinkscape ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showimg ;;
  esac
}

# Menu Archive Handlers
function showarch {
  showlogo
  echo -e " ${b}[ ARCHIVE HANDLERS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Ark (For KDE)
        2)    File-Roller (For GNOME)
        3)    Zip/Unzip
        4)    Rar/Unrar
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installark ;;
  2) installfileroller ;;
  3) installzipunzip ;;
  4) installrarunrar ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showarch ;;
  esac
}

# Menu Audio Applications
function showaudio {
  showlogo
  echo -e " ${b}[ AUDIO APPLICATIONS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Audacious (Player)
        2)    Amarok (Player - For KDE)
        3)    Banshee (Player - For Gnome)
        4)    Sonata (Player - Very Tiny)
        5)    Audacity (Recorder)
        6)    Ardour (Recorder)
        7)    Sweep (Recorder & Live Playback)
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installaudacious ;;
  2) installamarok ;;
  3) installbanshee ;;
  4) installsonata ;;
  5) installaudacity ;;
  6) installardour ;;
  7) installsweep ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; sh_Audio ;;
  esac
}

# Menu Web Applications
function showwebapps {
  showlogo
  echo -e " ${b}[ WEB APPLICATIONS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Chromium
        2)    Chrome
        3)    Youtube Downloader (Terminal)
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installchromium ;;
  2) installchrome ;;
  3) installytbdwn ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showwebapps ;;
  esac
}

# Menu Hacking Tools
function showhacktools {
  showlogo
  echo -e " ${b}[ HACKING TOOLS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Netool.sh
        2)    Veil
        3)    thad0ctor's Backtrack 5 Toolkit
        4)    LOIC (DDoS Tool)
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installnetool ;;
  2) installveil ;;
  3) installthad0ctor ;;
  4) installloic ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showhacktools ;;
  esac
}

# Menu Other Applications
function showothapps {
  showlogo
  echo -e " ${b}[ OTHER APPLICATIONS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Skype
        2)    TeamViewer
        3)    Gnome Tweak Tool
        4)    Terminator
        5)    Hamachi
        6)    Haguichi (GUI For Hamachi)
        7)    PHP5-cURL
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installskype ;;
  2) installteamviewer ;;
  3) installgnometweaktool ;;
  4) installterminator ;;
  5) installhamachi ;;
  6) installhaguichi ;;
  7) installphpcurl ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showothapps ;;
  esac
}

# Kali Default Applications Update
function showappupds {
  showlogo
  echo -e " ${b}[ KALI APPLICATIONS UPDATE ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Iceweasel
        2)    Adobe Flash Player
        3)    Joomscan Update
        4)    WPScan Update/Fix
        5)    Nmap & Zenmap Update
        6)    Metasploit Update
        7)    Veil Install/Update
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installiceweasel ;;
  2) installflashplugin ;;
  3) installjoomscan ;;
  4) installwpscan ;;
  5) installnmapzen ;;
  6) installmetasploit ;;
  7) installveil ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showappupds ;;
  esac
}

# Google Linux Repository
function showaddremglrepo {
  showlogo
  echo -e " ${b}[ GOOGLE LINUX REPOSITORY ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Add Google Linux Repository
        2)    Remove Google Linux Repository
       ---------------------------
        q)    Return To Main Menu"
  echo
  echo -en " Choose An Option: "
  read option
  case $option in
  1) installaddglrepo ;;
  2) installremglrepo ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showaddremglrepo ;;
  esac
}

# Other Operations
function showothops {
  showlogo
  echo -e " ${b}[ OTHER OPERATIONS ]${enda}"
  echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}"
  echo "        1)    Update/Restore 'sources.list' File
        2)    Add/Remove Google Linux Repository
       ---------------------------
        q)    Return To Main Menu"
  echo && echo -en " Choose An Option: "
  read option
  case $option in
  1) installsources ;;
  2) showaddremglrepo ;;
  q) sleep 1 ;;
  *) echo " \"$option\" Is Not A Valid Option"; sleep 1; showothops ;;
  esac
}

# Menu Links
function showlinks {
  showlogo
  echo -e " ${b}[ Usefull Links ]${enda}"
  echo -e " en0xCr3w Blog: ${bu}http://blog.en0xcr3w.com/${endc}"
  echo -e " Sourceforge KAAIS: ${bu}http://kaais.sourceforge.net/${endc}"
  echo -e " Kali Linux Community Forum: ${bu}http://www.kalilinux.net/${endc}"
  echo -e " Top-Hat-Sec: ${bu}http://www.top-hat-sec.com/${endc}"
  echo -e " r00tsect0r: ${bu}http://www.r00tsect0r.net/${endc}"
  echo -e " DuckDuckGo: ${bu}https://duckduckgo.com/${endc}"
  echo && echo -en " ${y}Press Enter To Return To Menu${endc}"
  read input
}

# Show About
function showabout {
  clear
  echo -e "
    ###########################################################
    #                  en0xCr3w  KAAISv3                      #
    #    Kali Applications Automatic Installation Script      #
    ###########################################################
    #    -- Op-System: Kali Linux                             #
    #    -- Codename: 'Sloth Install'                         #
    #    -- Version: v3 22-NOV-2014                           #
    #    -- Developer: rawstring                              #
    #    -- Thanks: r00tsect0r CyberTeam                      #
    #    --         r00t-3xp10it ~ Zylor ~ Azihak             #
    #    --         Anthony Smith ~ Luke Skywalka             #
    #    --         Cyb33rc0de - Bond Benz                    #
    ###########################################################

     ${b}Description${enda}
    This Script Is Meant To Help Users Install
    Their Favourite Applications On A Fresh Install
    Or Live Kali System, Saving Time To Use It.

     ${b}Notes${enda}
    You Need To Be In An Active Internet Connection
    And Be Running As ROOT In Order For This Script
    To Function. Any Other Use Given To It Resulting
    In A Script Mal-Functioning Is Not Our Responsibility.

     ${b}Reports${enda}
    You Can Report Your Findings, Are They Bugs Or
    Suggestions, On KAAIS SourceForge Page:
    ${u}${blue}https://sourceforge.net/p/kaais/discussion/${enda}.
    Bug Reports Will Be Taken In Consideration, And
    Proper Credits Will Be Added To The Script Description."
  echo && echo -en " ${yellow}Press Enter To Return To Main Menu${endc}"
  read input
}

# Exit KAAIS
function kexit () {
  showlogo && echo -e " ${y}Cleaning Apt-Get Packages...${endc}"
  xterm -e apt-get -y autoremove
  xterm -e apt-get -y autoclean
  showlogo && echo -e " Thank You For Using ${b}KAAIS${enda}
 For More Information Visit:
 ${b}==>> ${bu}http://en0xCr3w.com/${enda}"
  echo
  sleep 1
  exit
}

# Infinite Loop To Show Menu Untill Exit
while :
do
showlogo
echo -e " ${b}[ MAIN MENU ]${enda}"
echo -e " ${b}[${enda} Option ${b}]${enda} ${b}[${enda} Description ${b}]${enda}
        1)    Text Editors
        2)    FTP/Torrent Applications
        3)    Chat Applications
        4)    Image Editors
        5)    Archive Handlers
        6)    Audio Applications
        7)    Browser/Web Plugins
        8)    Hacking Tools
        9)    Other Applications
       10)    Default Applications (Update)
       11)    Other Operations
       12)    Usefull Links
      ------------------------
        a)    About KAAIS
        q)    Leave KAAIS"
echo
echo -en " Choose An Option: "
read option
case $option in
1) showtext ;;
2) showftptorr ;;
3) showchat ;;
4) showimg ;;
5) showarch ;;
6) showaudio ;;
7) showwebapps ;;
8) showhacktools ;;
9) showothapps ;;
10) showappupds ;;
11) showothops ;;
12) showlinks ;;
a) showabout ;;
q) kexit ;;
*) echo " \"$option\" Is Not A Valid Option"; sleep 1 ;;
esac
done

# End
