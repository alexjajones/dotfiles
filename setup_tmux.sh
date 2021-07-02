for dir in ~/jet/*/
do
    dir=${dir%*/}
    name=${dir##*/}

    echo $name

    cd $dir

    tmux new-session -s $name -d "vim ."
    tmux new-window -t "${name}:"
    tmux select-window -t $name:1.1
done
