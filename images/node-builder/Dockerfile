FROM node:7

# Install buildtools and prereqs
RUN mkdir -p /root/work/ \
    && apt-get -y update \
    && apt-get -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends install \
        ssh unzip git xvfb chromium libgconf-2-4 xauth \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*git --


# Install Chrome WebDriver
RUN CHROMEDRIVER_VERSION=2.27 && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver