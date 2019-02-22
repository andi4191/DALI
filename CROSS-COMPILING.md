# Building with the cross compiling containers 

## aarch64 Linux
### Build the aarch64 container 
```
docker build -t dali_builder:aarch64-linux -f Dockerfile.build.aarch64-linux .
```
### Compile
From the root of the DALI Tree
```
docker run --runtime=nvidia -v $(pwd):/dali -it dali_builder:aarch64-linux  
```