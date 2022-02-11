# compile for version
make
if [ $? -ne 0 ]; then
    echo "make error"
    exit 1
fi

app_version='2.6.1'
app_outname='pingtunnel'

# update 
go get -u -v github.com/xsgam/pingtunnel/...

# cross_compiles
make -f ./Makefile.cross-build

rm -rf ./release/packages
mkdir -p ./release/packages


#os_all='linux windows darwin freebsd'
#arch_all='386 amd64 arm arm64 mips64 mips64le mips mipsle'

os_all='linux windows darwin freebsd'
arch_all='386 amd64'


cd ./release

for os in $os_all; do
    for arch in $arch_all; do
        out_dir_name="${app_outname}_${app_version}_${os}_${arch}"
        app_path="./packages/${app_outname}_${app_version}_${os}_${arch}"

        if [ "x${os}" = x"windows" ]; then
            if [ ! -f "./${app_outname}_${os}_${arch}.exe" ]; then
                continue
            fi
            
            mkdir ${app_path}
            mv ./${app_outname}_${os}_${arch}.exe ${app_path}/${app_outname}.exe
        else
            if [ ! -f "./${app_outname}_${os}_${arch}" ]; then
                continue
            fi
            
            mkdir ${app_path}
            mv ./${app_outname}_${os}_${arch} ${app_path}/${app_outname}
        fi  
        #cp ../LICENSE ${app_path}
        #cp -rf ../conf/* ${app_path}

        # packages
        cd ./packages
        if [ "x${os}" = x"windows" ]; then
            zip -rq ${out_dir_name}.zip ${out_dir_name}
        else
            tar -zcf ${out_dir_name}.tar.gz ${out_dir_name}
        fi  
        cd ..
        
        echo "del: ${app_path}"
        rm -rf ${app_path}
    done
done

cd -
