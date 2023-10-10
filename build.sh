

function running {
    if [ -e "build" ]; then
        echo "-- have build dir"
    else
        echo "-- create build dir"
        mkdir build
    fi

    . ./board/$BOARD/export.sh

    cd build
    cmake ..
    make
    cd ../

    function menuconfig {
        cd build
        make menuconfig
        cd ../
    }
    export -f menuconfig

    function clean {
        cd build
        make clean
        cd ../
    }
    export -f clean

    function build {
        cd build
        make -j4
        cd ../
    }
    export -f build

}


if [ $# -eq 1 ]; then

    echo "-- run board/$1"
    export BOARD=$1

    if [ -e "board/$1" ]; then
        running
    else
        echo "-- board/$1 folder not found"
    fi

else
	echo "-- Please enter the board level folder for execution!!"
fi



