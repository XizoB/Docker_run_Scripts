FROM xizobu/ros2_conda:4.0

# ARG DEBIAN_FRONTEND=noninteractive

# COPY /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu
# COPY /usr/lib/i386-linux-gnu /usr/lib/i386-linux-gnu
 
COPY 10_nvidia.json /usr/share/glvnd/egl_vendor.d/10_nvidia.json
 
RUN echo '/usr/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    echo '/usr/lib/i386-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    ldconfig
 
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
 
# ARG DEBIAN_FRONTEND=noninteractive

# ENV NVIDIA_VISIBLE_DEVICES \
#     ${NVIDIA_VISIBLE_DEVICES:-all}
# ENV NVIDIA_DRIVER_CAPABILITIES \
#     ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all