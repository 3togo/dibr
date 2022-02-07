#! /bin/bash
PACKAGES="libx11-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxrandr-dev libxext-dev libxcursor-dev libxinerama-dev libxi-dev libglfw3-dev"
MISSING=$(dpkg --get-selections $PACKAGES 2>&1 | grep -v 'install$' | awk '{ print $6 }')
# Optional check here to skip bothering with apt-get if $MISSING is empty
if [ -n "$MISSING" ]; then
    cmd="sudo apt-get install $MISSING"
    echo $cmd
    $cmd
fi

mkdir -p build
cd build
for mdir in images gls; do
    cmd="ln -sf ../$mdir ."
    echo $cmd
    $cmd
done
cmake ..
make -j $(nproc)
[[ "$?" -ne "0" ]] && echo "make error!" && exit $?
[[ ! -f dibr ]] && echo "dibr not found" && exit 1
cmd="./dibr u 0.1 0.0 images/stilllife-tex.jpg images/stilllife-depth.jpg 0 0 0"
echo $cmd
$cmd
