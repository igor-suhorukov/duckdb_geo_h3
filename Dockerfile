FROM debian:bullseye
RUN apt update
RUN apt install -y awscli build-essential libssl-dev pigz unzip 
RUN apt install -y wget
RUN cd ~ && wget -c https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0.tar.gz
RUN ls -la
RUN cd ~ && tar -xzf cmake-3.20.0.tar.gz
RUN cd ~ && cd cmake-3.20.0 &&./bootstrap --parallel=$(nproc) && make -j$(nproc) && make install
RUN apt install -y git
RUN git clone https://github.com/isaacbrodsky/h3-duckdb ~/duckdb_h3
RUN cd ~/duckdb_h3 && git submodule update --init && cd duckdb && git checkout 28f4d18 && cd ..
RUN cd ~/duckdb_h3 && CMAKE_BUILD_PARALLEL_LEVEL=$(nproc) make release
RUN git clone https://github.com/igor-suhorukov/geo ~/duckdb_geo && cd ~/duckdb_geo && git submodule init && git submodule update --recursive --remote && cd .. && mkdir -p build/release
RUN cd ~/duckdb_geo  && cmake ./duckdb/CMakeLists.txt -DEXTERNAL_EXTENSION_DIRECTORIES=../geo -DCMAKE_BUILD_TYPE=RelWithDebInfo -DEXTENSION_STATIC_BUILD=1 -DBUILD_TPCH_EXTENSION=1 -DBUILD_PARQUET_EXTENSION=1 -B build/release && CMAKE_BUILD_PARALLEL_LEVEL=$(nproc) cmake --build build/release
