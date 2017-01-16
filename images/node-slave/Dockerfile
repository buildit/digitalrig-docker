FROM rig/slave

ENV NODE_VERSION 7.3.0

# Install tools and prereqs
RUN mkdir -p /root/work/ \
    && apt-get -y update \
    && apt-get -y install unzip \
    && apt-get -y install git \
    && apt-get -y install xvfb chromium-browser libgconf-2-4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*git --

# Install Node
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm -f "node-v$NODE_VERSION-linux-x64.tar.gz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs


# Install Chrome WebDriver
RUN CHROMEDRIVER_VERSION=2.26 && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver