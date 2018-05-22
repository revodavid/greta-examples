tensorflow::install_tensorflow_extras("tensorflow-probability")
tensorflow::install_tensorflow(version="1.8.0",extra_packages="tensorflow-probability")
devtools::install_github("greta-dev/greta@dev")

## see: https://askubuntu.com/questions/859256/how-to-install-gcc-7-or-clang-4-0
install.packages('DiagrammeR')

