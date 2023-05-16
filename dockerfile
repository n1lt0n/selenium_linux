FROM ubuntu

# Instalação de pré-requisitor para instalação do selenium
RUN apt-get update
RUN apt-get install -y unzip 
RUN apt-get install -y xvfb
RUN apt-get install -y libxi6
RUN apt-get install -y libgconf-2-4
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y gnupg
RUN apt-get install -y default-jdk

# Instalação do google-chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN bash -c "echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google-chrome.list"
RUN apt-get update
RUN apt-get install -y google-chrome-stable

# Instalando chrome-driver
RUN google-chrome --version
RUN echo $(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
RUN wget https://chromedriver.storage.googleapis.com/$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver

# Download de jar files Selenium
RUN wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar 
RUN mv selenium-server-standalone-3.141.59.jar selenium-server-standalone.jar
RUN wget http://www.java2s.com/Code/JarDownload/testng/testng-6.8.7.jar.zip
RUN unzip testng-6.8.7.jar.zip

EXPOSE 4444

CMD [ "xvfb-run", "java", "-Dwebdriver.chrome.driver=/usr/bin/chromedriver", "-jar", "selenium-server-standalone.jar", "-debug" ]