#!/bin/bash
set -eu

SSHPATH="$HOME/.ssh"
mkdir "$SSHPATH"
echo "$SSH_PRIVATE_KEY" > "$SSHPATH/key"
chmod 600 "$SSHPATH/key"
SERVER_DEPLOY_STRING="$REMOTE_USER@$REMOTE_HOST:$TARGET_DIRECTORY"

# Run Rsync synchronization
sh -c "rsync $ARGS -e 'ssh -i $SSHPATH/key -o StrictHostKeyChecking=no -p $REMOTE_HOST_PORT' . $SERVER_DEPLOY_STRING"


#Run cmd command insid server
echo "$SSHPATH/key $SERVER_DEPLOY_STRING -p $REMOTE_HOST_PORT"
ssh "$SSHPATH/key $SERVER_DEPLOY_STRING -p $REMOTE_HOST_PORT"

cd "$TARGET_DIRECTORY" && php artisan optimize
echo date /t >> logDeploy.txt
echo "Comando pos deploy executado" >> logDeploy.txt