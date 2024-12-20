#!/bin/bash

REPO_LOCAL="~/UTN-FRA_SO_Examenes/202406"
RTA_EXAMEN="~/RTA_Examen_$20241119"
DEST_REPO="~/UTNFRA_SO_2do_Parcial_Castanheira Becq Carola"

history -a

mkdir -p "$DEST_REPO"

cp -r "$REPO_LOCAL" "$DEST_REPO"

cp -r "$RTA_EXAMEN" "$DEST_REPO"

cp ~/.bash_history "$DEST_REPO/.bash_history"

touch "$DEST_REPO/Readme.md"

cd "$DEST_REPO" || exit 1

git add .
git commit -m "Punto E"


git push origin main
