function conda-init
    set -gx PATH /home/krishom/miniconda3/bin $PATH
    eval (/home/krishom/miniconda3/bin/conda shell.fish hook)
end
