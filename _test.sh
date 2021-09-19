#!$SHELL
test(){
    echo
}

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