#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Использование: $0 <путь_к_источнику> <путь_к_назначению>"
    exit 1
fi

source_dir=$1
destination_dir=$2

mkdir -p "$destination_dir"

while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    if [ -e "$destination_dir/$filename" ]; then
        base=${filename%.*}
        extension=${filename##*.}
        counter=1
        while [ -e "$destination_dir/$base-$counter.$extension" ]; do
            ((counter++))
        done
        filename="$base-$counter.$extension"
    fi
    cp "$file" "$destination_dir/$filename"
done < <(find "$source_dir" -type f -print0)

echo "Готово"

