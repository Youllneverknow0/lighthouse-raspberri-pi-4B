#!/bin/bash

main()
{
	set_script_parameters
	install_tools
	get_lighthouse_src
	get_leveldb_src
	use_leveldb_in_lighthouse
	compile_lighthouse_testnet5
	make_lighthouse_available
	tidy_up
}

set_script_parameters()
{
	#make script verbose to see everything
	set -x
}

install_tools()
{
	apt-get install git
	apt-get install cargo
}

get_lighthouse_src()
{
	git clone https://github.com/sigp/lighthouse
}

get_leveldb_src()
{
	git clone https://github.com/skade/leveldb
}

use_leveldb_in_lighthouse()
{
	cp -v ./leveldb/src/database/* ./.cargo/registry/src/github.com-1ecc6299db9ec823/leveldb-0.8.4/src/database
}

compile_lighthouse_testnet5()
{
	cd lighthouse
	git checkout testnet5
	make
}

make_lighthouse_available()
{
	cp ~/.cargo/bin/lighthouse /usr/bin/
}

tidy_up()
{
	echo "Do you want to delete the cloned repositories? [y/n]"
	read delRep

	if [ $delRep == "y" ]
	then
		rm -rf ./leveldb
		rm -rf ./lighthouse
	fi
}

main $@

