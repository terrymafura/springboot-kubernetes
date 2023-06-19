# Makefile for installing and running Minikube on various operating systems

# Determine the current operating system
ifeq ($(OS),Windows_NT)
	OS := Windows
else ifeq ($(shell uname -s),Darwin)
	OS := macOS
	MACHINE := $(shell uname -m)
	ifeq ($(MACHINE),x86_64)
		ARCH := amd64
	else ifeq ($(MACHINE),arm64)
		ARCH := arm64
	else
		$(error Unsupported machine architecture: $(MACHINE))
	endif
else ifeq ($(shell uname -s),Linux)
	OS := Linux
else
	$(error Unsupported operating system: $(shell uname -s))
endif

# Minikube installation command for macOS (Intel)
install_macos_intel:
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 \
		&& sudo install minikube-darwin-amd64 /usr/local/bin/minikube \
		&& rm minikube-darwin-amd64

# Minikube installation command for macOS (Apple Silicon)
install_macos_arm:
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-arm64 \
		&& sudo install minikube-darwin-arm64 /usr/local/bin/minikube \
		&& rm minikube-darwin-arm64

# Minikube installation command for Linux
install_linux:
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
		&& sudo install minikube-linux-amd64 /usr/local/bin/minikube \
		&& rm minikube-linux-amd64

# Minikube installation command for Windows
install_windows:
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64.exe \
		&& move minikube-windows-amd64.exe minikube.exe

# Minikube installation target based on the current operating system and architecture
install:
ifeq ($(OS),macOS)
ifeq ($(ARCH),amd64)
	$(MAKE) install_macos_intel
else ifeq ($(ARCH),arm64)
	$(MAKE) install_macos_arm
endif
else ifeq ($(OS),Linux)
	$(MAKE) install_linux
else ifeq ($(OS),Windows)
	$(MAKE) install_windows
endif

# Start Minikube cluster
start:
	minikube start

# Stop Minikube cluster
stop:
	minikube stop

# Delete Minikube cluster
delete:
	minikube delete

.PHONY: install install_macos_intel install_macos_arm install_linux install_windows start stop delete