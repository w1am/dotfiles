function fish_user_key_bindings
  bind \cC 'commandline ""'
end

function nvm
  bass source ~/.nvm/nvm.sh ';' nvm $argv
end

alias nv="nvim"
alias py="python3"
alias pip="pip3"
alias e="exit"
alias rm="trash-put"
alias re="restore-trash"
alias em="trash-empty"
alias yard="ffplay rtsp://admin:examplepass123@192.168.100:554/Streaming/Channels/102"
alias buzzer="ffplay rtsp://admin:examplepass123@192.168.100:554/Streaming/Channels/202"
alias garage="ffplay rtsp://admin:examplepass123@192.168.100:554/Streaming/Channels/302"
alias driveway="ffplay rtsp://admin:examplepass123@192.168.100:554/Streaming/Channels/402"

set -g -x fish_greeting ''

set JAVA_HOME /usr/lib/jvm/jdk-16.0.1/
set CATALINA_HOME /etc/tomcat9
