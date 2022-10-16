#! /usr/bin/env bash
# Useful functions

#Array functions

# return 0 (true) if first arg contains in string passed as second argument. 1 (false) otherwise
function in_string () {
  echo "1 arg: $1"
  echo "2 arg: $2"
  if [[ "$2" == *"$1"* ]]; then
return 0
  else
return 1
  fi
}

function include () {
. `realpath $0 | xargs -I{} dirname {}`/$1
}

include "../modules/mysql.sh"
nd="3"
ar="2+3+1+4"
if in_string $nd $ar; then
echo "truelike";
else
echo "falselike";
fi
