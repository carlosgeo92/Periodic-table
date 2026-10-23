#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
	echo "Please provide an element as an argument."
#commit feat: non value message
else

  PERIODIC_TABLE_DATA=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) ORDER BY atomic_number")
  
  FLAG=TRUE
  while IFS='|' read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
  do
    if [[ $1 = $ATOMIC_NUMBER || $1 = $SYMBOL || $1 = $NAME ]]
		then
			echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
			FLAG=FALSE
			break 
		fi

  done < <(echo "$PERIODIC_TABLE_DATA")

  if [[ $FLAG = TRUE ]]
  then
    echo "I could not find that element in the database."
  fi

fi