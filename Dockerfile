FROM centos:7

RUN echo "--------Install JDK11--------"
RUN yum install -y java-11
CMD ["/bin/bash"]

RUN echo "------Install JMeter-------"
ENV JMETER_VERSION 5.4.1
ADD https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz /opt/
RUN tar -xvf /opt/apache-jmeter-${JMETER_VERSION}.tgz -C /opt/

ADD plugins/ /opt/apache-jmeter-${JMETER_VERSION}/lib/

ENV JMETER_BIN /opt/apache-jmeter-${JMETER_VERSION}/bin
ENV PATH $PATH:$JMETER_BIN
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}

RUN echo "------------ Install chrome dependencies including Xvfb------------"
RUN yum install pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc libappindicator-gtk3 liberation-fonts xkbcomp libxkbfile libXdmcp.x86_64 libXfont2.x86_64 xorg-x11-server-common.x86_64 xorg-x11-xauth.x86_64 xorg-x11-server-Xvfb.x86_64 -y
RUN yum install wget -y && \
	yum install vulkan -y && \
	yum install xdg-utils -y && \
	yum clean all && \
	rm -rf /var/cache/yum/*

RUN echo "------------ Install unzip ------------"
RUN yum install -y unzip

RUN echo "------------ Install Google Chrome ------------"
RUN yum install -y https://dl.google.com/linux/chrome/rpm/stable/x86_64/google-chrome-stable-89.0.4389.114-1.x86_64.rpm
#89.0.4389.114

RUN echo "------------ Install Chrome Driver ------------"
RUN mkdir -p /webdriver /jubilee_workspace
WORKDIR /webdriver
RUN curl -O https://chromedriver.storage.googleapis.com/89.0.4389.23/chromedriver_linux64.zip > chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip chromedriver && rm -r chromedriver_linux64.zip

WORKDIR /jubilee_workspace