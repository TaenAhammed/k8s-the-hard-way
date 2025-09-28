# Makefile for managing Lima VMs

.DEFAULT_GOAL := status
LIMA_CONFIG_DIR := lima-configs
VMS = jumpbox control-plane worker-1 worker-2

.PHONY: start stop status delete

start:
	limactl start --tty=false --name=jumpbox $(LIMA_CONFIG_DIR)/jumpbox.yaml
	limactl start --tty=false --name=control-plane $(LIMA_CONFIG_DIR)/cp.yaml
	limactl start --tty=false --name=worker-1 $(LIMA_CONFIG_DIR)/w.yaml
	limactl start --tty=false --name=worker-2 $(LIMA_CONFIG_DIR)/w.yaml

stop:
	@for vm in $(VMS); do \
		echo "Stopping $$vm..."; \
		limactl stop $$vm || true; \
	done

restart:
	@for vm in $(VMS); do \
		echo "Restarting $$vm..."; \
		limactl restart $$vm || true; \
	done

status:
	@limactl list

delete:
	@for vm in $(VMS); do \
		echo "Deleting $$vm..."; \
		limactl delete $$vm || true; \
	done
