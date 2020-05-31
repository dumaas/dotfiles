# Place additions to $PATH here
path+="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
path+=('/home/dumaas/.gem/ruby/2.7.0/bin')

export PATH

# Configure cs50 library to work
export LD_LIBRARY_PATH=/usr/local/lib
export LIBRARY_PATH=/usr/local/lib
export C_INCLUDE_PATH=/usr/local/include
