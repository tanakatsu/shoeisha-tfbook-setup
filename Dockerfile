FROM tensorflow/tensorflow:1.5.0-gpu-py3

RUN apt-get -y update && apt-get -y install language-pack-ja wget unzip cmake libgtk2.0-dev libjpeg-dev libpng-dev libtiff-dev

# locale setting
RUN locale-gen ja_JP.UTF-8
ENV LANGUAGE ja_JP:en
ENV LC_ALL ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
RUN update-locale LANG=$LANG

# install opencv3
WORKDIR /root
ENV PYTHON_INCLUDE_DIRS /usr/include/python3.5
ENV PYTHON_LIBRARIES /usr/lib/x86_64-linux-gnu/libpython3.5m.so
RUN wget https://github.com/Itseez/opencv/archive/3.2.0.zip \
    && wget https://github.com/Itseez/opencv_contrib/archive/3.2.0.zip \
    && unzip 3.2.0.zip \
    && unzip 3.2.0.zip.1
RUN cd opencv-3.2.0 \
    && mkdir build \
    && cd build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib-3.2.0/modules \
    -D BUILD_opencv_java=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=ON \
    -D WITH_TBB=OFF \
    -D WITH_QT=OFF \
    -D WITH_1394=OFF \
    -D WITH_CUDA=OFF .. \
    && make -j8 \
    && make install \
    && ldconfig \
    && ln /dev/null /dev/raw1394 \
    && rm /root/3.2.0.zip /root/3.2.0.zip.1 \
    && rm -r /root/opencv-3.2.0 /root/opencv_contrib-3.2.0

RUN wget https://www.shoeisha.co.jp/static/book/download/9784798154121/requirements.txt \
    && pip install --no-cache-dir -r requirements.txt

WORKDIR /notebooks
