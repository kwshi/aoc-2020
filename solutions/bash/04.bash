#!/bin/bash -eu

declare -A doc

function keys_exist {
  for k in 'byr' 'iyr' 'eyr' 'hgt' 'hcl' 'ecl' 'pid'
  do
    if [[ -z ${doc[$k]+_} ]]
    then return 1
    fi
  done
}

function keys_valid {
  local byr=${doc['byr']}
  local iyr=${doc['iyr']}
  local eyr=${doc['eyr']}
  local hgt=${doc['hgt']}
  local hcl=${doc['hcl']}
  local ecl=${doc['ecl']}
  local pid=${doc['pid']}

  [[ $byr =~ ^[0-9]{4}$ && $byr -ge 1920 && $byr -le 2002 ]] || return 1
  [[ $iyr =~ ^[0-9]{4}$ && $iyr -ge 2010 && $iyr -le 2020 ]] || return 1
  [[ $eyr =~ ^[0-9]{4}$ && $eyr -ge 2020 && $eyr -le 2030 ]] || return 1
  [[ $hgt =~ ^[0-9]+cm$ && ${hgt::-2} -ge 150 && ${hgt::-2} -le 193
  || $hgt =~ ^[0-9]+in$ && ${hgt::-2} -ge 59 && ${hgt::-2} -le 76
  ]] || return 1
  [[ $hcl =~ ^#[0-9a-f]{6}$ ]] || return 1
  [[ $ecl =~ ^amb|blu|brn|gry|grn|hzl|oth$ ]] || return 1
  [[ $pid =~ ^[0-9]{9}$ ]] || return 1
}

v1=0
v2=0

i=0

while read -ra line
do
  if [[ ${#line[@]} -eq 0 ]] 
  then
    # shellcheck disable=SC2015
    keys_exist && (( ++v1 )) || true

    # shellcheck disable=SC2015
    keys_exist && keys_valid && (( ++v2 )) || true

    unset doc
    declare -A doc
  fi

  for kv in "${line[@]}"
  do
    k=${kv%:*}
    v=${kv#*:}
    doc[$k]=$v
  done
  
done
echo "$v1 $v2"

