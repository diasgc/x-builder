#!$SHELL

C0="\e[0m" CW="\e[97m"  CD="\e[90m" CW2="\e[38;5;234m" CW3="\e[38;5;238m" CW4="\e[38;5;242m"  CW5="\e[38;5;246m" CW6="\e[38;5;250m"
CR0="\e[31m" CR1="\e[91m" CR2="\e[38;5;52m" CR3="\e[38;5;88m" CR4="\e[38;5;124m" CR5="\e[38;5;160m"  CR6="\e[38;5;196m"
CY0="\e[33m" CY1="\e[93m" CY2="\e[38;5;58m" CY3="\e[38;5;94m" CY4="\e[38;5;136m" CY5="\e[38;5;178m"  CY6="\e[38;5;220m"
CG0="\e[32m" CG1="\e[92m" CG2="\e[38;5;46m" CG3="\e[38;5;82m" CG4="\e[38;5;118m" CG5="\e[38;5;154m"  CG6="\e[38;5;190m"
CC0="\e[36m" CC1="\e[96m" CC2="\e[38;5;49m" CC3="\e[38;5;85m" CC4="\e[38;5;122m" CC5="\e[38;5;123m"  CC6="\e[38;5;195m"
CB0="\e[34m" CB1="\e[94m" CB2="\e[38;5;26m" CB3="\e[38;5;69m" CB4="\e[38;5;111m" CB5="\e[38;5;152m"  CB6="\e[38;5;153m"
CM0="\e[35m" CM1="\e[95m" CM2="\e[38;5;54m" CM3="\e[38;5;91m" CM4="\e[38;5;126m" CM5="\e[38;5;162m"  CM6="\e[38;5;198m"

CO0="\e[38;5;130m" CO1="\e[38;5;166m" CO2="\e[38;5;202m" CO3="\e[38;5;208m"  CO4="\e[38;5;214m" CO5="\e[38;5;220m" CO6="\e[38;5;223m"
CF0="\e[38;5;53m"  CF1="\e[38;5;89m"  CF2="\e[38;5;125m" CF3="\e[38;5;161m"  CF4="\e[38;5;197m" CF5="\e[38;5;211m" CF6="\e[38;5;219m"
CL0="\e[38;5;34m" CL1="\e[38;5;72m" CL2="\e[38;5;114m" CL3="\e[38;5;120m"  CL4="\e[38;5;156m" CL5="\e[38;5;192m" CL6="\e[38;5;230m"

pushvar_f(){
  local name=$1; shift; eval $name=\"$@ ${!name}\"
}

pushvar_l(){
  local name=$1; shift; eval $name=\"${!name} $@\"
}

# exclusive variable add left var_xaddl <variable> <substrings...>
# appends substrings to the start of main variable iff main doesnt contains substring
var_xaddl(){
  local v=$1; shift
    while [ -n "$1" ];do
        [ -z "${!v##*${1}*}" ] || eval $v=\"${1} ${!v}\"
        shift
    done
}

# exclusive variable add right var_xaddr <variable> <substrings...>
# appends substrings to the start of main variable iff main doesnt contains substring
var_xaddr(){
    local v=$1; shift
    while [ -n "$1" ];do
        [ -z "${!v##*${1}*}" ] || eval $v=\"${!v} ${1} \"
        shift
    done
}

var_addr(){
    local v=$1; shift; eval $v=\"${!v} $@\"
}

var_addl(){
    local v=$1; shift; eval $v=\"$@ ${!v}\"
}

topct(){
  local p1
  local p2
  while read -r ln; do
    p1="$(grep -oP '\d+%' <<< $ln)   "
    [ -n "$p2" ] && echo -ne "\e[${#p2}D"
    echo -ne "${p1}"
    p2=$p1
  done
  p2="$p2 "
  echo -ne "\e[${#p2}D"
}

prt_progress(){
  printf "%-6s"
  while read -r ln; do
    printf "\e[6D%-6s" $(grep -oP '\d+%' <<< $ln)
  done
  printf "\e[6D"
}

err(){
  echo -e "${CR0}ERROR!${C0}"
}

wget_tar(){
  local tag="source"
  local args=
  echo -ne "${CD}${tag}${C0}"
  case $1 in
    *.tar.lz) 
      test -z $(which lzip) && aptInstall lzip
      ags="--lzip -xv"
      ;;
    *.tar.gz) args="-xvz";;
    *.tar.xz|*.tar.bz2) args="-xvJ";;
    *) err;
  esac
  [ -d "tmp" ] && rm -rf tmp
  mkdir -p tmp
  wget -O - $1 2>prt_progress | tar --transform 's/^dbt2-0.37.50.3/dbt2/' $args -C tmp >"$(pwd)/wget_tar.log" || err
  cd tmp
  mv * $2 && mv $2 ..
  cd ..
  rm -rf tmp
  echo -e "${CG0}\e[${#tag}D${tag} done${C0}\n"
}

list_scripts(){
  for f in $(ls -1 *.sh); do
    case $f in
      _test*|build*|xbuild*|xsetup*|cmake*|xunpack*);;
      *)  cfg=$(./${f} --get var cfg)
          [ -n "cfg" ] && printf "%-26s %s\n" ${f::-3} $cfg >> readme.txt
          ;;
    esac
  done
}

check_tf(){
  [ "${1}" == "ok" ] && return 0 || return 1
}