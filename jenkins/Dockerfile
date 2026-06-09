FROM jenkins/jenkins:lts-jdk21

USER root

RUN apt-get update && apt-get install -y \
    ca-certificates curl gnupg lsb-release && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg \
      | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) \
      signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" \
      > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Use -f so it doesn't fail if group exists, use correct GID

COPY server.crt /usr/local/share/ca-certificates/devstack.crt
RUN update-ca-certificates

RUN groupadd -f -g 960 docker && usermod -aG docker jenkins

USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=true"

FROM nginx:alpine
RUN echo "<h1>Built by Jenkins, pushed to local registry</h1>" \
    > /usr/share/nginx/html/index.html
