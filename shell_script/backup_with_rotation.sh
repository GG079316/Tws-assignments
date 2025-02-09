Src_dir="$1"


if [ ! -d "$Src_dir" ];
then
        echo "directory does not exists"
        exit 1
fi

backup_dir="$Src_dir/backups"

mkdir -p "$backup_dir"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FOLDER="$backup_dir/backup_$TIMESTAMP"

mkdir "$BACKUP_FOLDER"

cp -r "$Src_dir"/* "$BACKUP_FOLDER"

echo "Backup created : $BACKUP_FOLDER"

count=$(ls -l "$backup_dir" | grep -c ^d)

if [ "$count" -gt 3 ];
then

         BACKUP_TO_DELETE=$(ls -t "$backup_dir" | tail -n +4)
    for folder in $BACKUP_TO_DELETE; do
        rm -rf "$backup_dir/$folder"
        echo "Deleted old backup: $folder"
    done
fi

exit 0
                      
