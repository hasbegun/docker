FROM ubuntu:18.04

RUN apt-get update --fix-missing && apt-get install tzdata -qy &&\
	apt-get install -qy \
	build-essential pkg-config sudo vim cmake git wget xauth bzip2 libblas-dev liblapack-dev \
	python3-dev python3-numpy python3-scipy python3-pip python3-setuptools \
	openssh-server \
	texlive-latex-base latexmk

RUN pip3 install -U pip setuptools

WORKDIR /workspace

# Install Psi4.
RUN cd /workspace; wget http://vergil.chemistry.gatech.edu/psicode-download/psi4conda-1.2.1-py36-Linux-x86_64.sh
RUN echo '/usr/local/psi4conda' | bash /workspace/psi4conda-1.2.1-py36-Linux-x86_64.sh
RUN rm /workspace/psi4conda-1.2.1-py36-Linux-x86_64.sh
RUN export PATH=/usr/local/psi4conda/bin:$PATH

# Install PySCF.
RUN cd /workspace; git clone https://github.com/sunqm/pyscf
RUN cd /workspace/pyscf/pyscf/lib; mkdir build; cd build; cmake ..; make

# Install OpenFermion, Cirq, and plugins.
RUN pip3 install openfermion
RUN pip3 install cirq
RUN pip3 install openfermioncirq
RUN pip3 install openfermionpsi4
RUN pip3 install openfermionpyscf

# Update paths
RUN export PATH=/usr/local/psi4conda/bin:$PATH
RUN export PYTHONPATH=/usr/local/pyscf:$PYTHONPATH

# Make python point to python3
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip

CMD ["/bin/bash"]
