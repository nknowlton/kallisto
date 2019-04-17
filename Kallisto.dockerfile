FROM bitnami/minideb:stretch as builder
LABEL maintainer=n.knowlton@auckland.ac.nz

RUN install_packages wget ca-certificates 
# Download and install kallisto into root folder
RUN wget https://github.com/pachterlab/kallisto/releases/download/v0.44.0/kallisto_linux-v0.44.0.tar.gz && tar -xzf kallisto_linux-v0.44.0.tar.gz

# Create a new layer with the Kallisto script only removing ca-certs and wget packages
FROM bitnami/minideb:stretch
COPY --from=builder /kallisto_linux-v0.44.0/ /kallisto_linux-v0.44.0/
ENV PATH="/kallisto_linux-v0.44.0:${PATH}"
# Run Kallisto
ENTRYPOINT [ "kallisto"] 
# Allow shell to grab and pass in arguments to kallisto
CMD [ "sh","-c","$HOME" ]
