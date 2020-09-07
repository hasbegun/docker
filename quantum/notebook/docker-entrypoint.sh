#!/bin/bash
$USER=developer
bash -c '/home/${USER}/set_theme.sh || echo -e "${RED}ERROR: set_theme.sh failed.${NC}"'
# WARNING: The init_notebook.sh must be run after set_theme.sh!
bash -c '/home/${USER}/init_notebook.sh || echo -e "${RED}ERROR: init_notebook.sh failed.${NC}"'
bash -c 'cd $WORKDIR && nohup sh -c "jupyter notebook --ip=0.0.0.0 --no-browser" > /home/$NB_USER/jupyter.log &'
# I don't know why I added this line, but ok, let's sleep.
bash -c 'sleep 0.1s'
/bin/bash