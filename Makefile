.PHONY: all build release clean install copy help

# Default target
all: release

# Build release version with musl (statically linked)
release:
	@echo "Building statically-linked release binary..."
	cargo build --release --target x86_64-unknown-linux-musl

# Build debug version with musl
debug:
	@echo "Building statically-linked debug binary..."
	cargo build --target x86_64-unknown-linux-musl

# Alias for release
build: release

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	cargo clean

# Install binary to /usr/local/bin (requires sudo)
install: release
	@echo "Installing jdbrowser to /usr/local/bin..."
	@sudo install -m 755 target/x86_64-unknown-linux-musl/release/jdbrowser /usr/local/bin/

# Copy binary to local and remote directories
copy: release
	@echo "Copying jdbrowser to ~/source/bin..."
	@mkdir -p ~/source/bin
	@cp target/x86_64-unknown-linux-musl/release/jdbrowser ~/source/bin/
	@echo "Copying jdbrowser to wasd:/root/source/bin..."
	@ssh wasd "mkdir -p /root/source/bin && rm -f /root/source/bin/jdbrowser"
	@scp target/x86_64-unknown-linux-musl/release/jdbrowser wasd:/root/source/bin/
	@echo "Copy complete ✓"

# Check if binary is statically linked
check-static: release
	@echo "Checking if binary is statically linked..."
	@ldd target/x86_64-unknown-linux-musl/release/jdbrowser || echo "Binary is statically linked ✓"

# Run the application
run: release
	@./target/x86_64-unknown-linux-musl/release/jdbrowser

# Show help
help:
	@echo "JDbrowser Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make          - Build release version (default)"
	@echo "  make release  - Build statically-linked release binary"
	@echo "  make debug    - Build statically-linked debug binary"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make install  - Install binary to /usr/local/bin (requires sudo)"
	@echo "  make copy     - Copy binary to ~/source/bin and wasd:/root/source/bin"
	@echo "  make check-static - Verify binary is statically linked"
	@echo "  make run      - Build and run the application"
	@echo "  make help     - Show this help message"
