## PCI passthrough setup

References:

[minikube gpu docs](https://github.com/kubernetes/minikube/blob/master/docs/gpu.md)

[archlinux pci passthrough](https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF)

[gpu passthrough for gaming on windows](https://davidyat.es/2016/09/08/gpu-passthrough/)

[gpu passthrough for gaming on windows 2](https://forum.level1techs.com/t/play-games-in-windows-on-linux-pci-passthrough-quick-guide/108981)

This readme is a quick overview on how I did pci passthrough on my particular setup

OS version
```
cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
```

GPU model (output from `nvidia-smi`)
```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 390.67                 Driver Version: 390.67                    |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 1080    Off  | 00000000:00:07.0 Off |                  N/A |
|  0%   46C    P0    39W / 180W |      0MiB /  8119MiB |      2%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```


This configuration and checklist is specifically designed for this machine.

## Hardware requirements
1. Enable VT-d intel technology in the BIOS
2. Ensure there are 2 seperate graphics cards installed in the machine
3. Ensure there are 2 seperate monitors for each graphics card

## Software requirements
4. Ensure vfio kernal modules are in /etc/modules
5. Add your specific pcie device ids in grub.passthrough file by running check_pci_passthrough.sh 
6. Run enable_pci_passthrough.sh to update the grub config for passthrough
7. Run disable_pci_passthrough.sh to update the grub config for no passthrough

8. Reboot system
9. Run check_pci_passthrough.sh and make sure "Kernel driver in use" is one of `vfio-pci` or `pci-stub`
10. Run start-minikube-gpu.sh for a single node kubernetes cluster with gpu access :O
