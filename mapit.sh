mapfile -t -d: <<<"$PATH"
echo "${MAPFILE[0]}"


echo "hello frogs" > ${MAPFILE[0]}/frogs.txt
