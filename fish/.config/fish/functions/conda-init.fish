function conda-init
    set -gx PATH /home/krishom/anaconda3/bin $PATH
    eval (/home/krishom/anaconda3/bin/conda shell.fish hook)
end
