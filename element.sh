#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
fi

if [[ $1 ]]
  then
  if [[ $1 =~ ^[0-9]+$ ]]
    then
      ELEMENT_INFO=$($PSQL "select atomic_number, name,symbol ,type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number=$1 order by atomic_number;")
    else
      ELEMENT_INFO=$($PSQL "select atomic_number, name,symbol ,type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where name='$1' or symbol='$1' order by atomic_number;")
  fi
    if [[ -z $ELEMENT_INFO ]]
      then
        echo "I could not find that element in the database."
      else
        echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
        done
    fi
fi
