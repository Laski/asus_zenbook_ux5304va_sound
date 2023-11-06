<p align="center">SSDT Patch to fix missing speakers sound on Asus Zenbook s13 Oled UX5304VA</br>


# Steps

1. Get into UEFI configuration (F2 repeteadly on boot) and disable Secure Boot.
2. Clone this repo.
3. Run
```
chmod +x step-1-patch-kernel.sh
sudo ./step-1-patch-kernel.sh
```
and follow the instructions. The script will download your current kernel sources, patch them, recompile and install it again with a different name (`-asus-speakers-patch` at the end).
Your computer will reboot automatically at the end.

4. You can now run

```
chmod +x step-2-patch-acpi-table.sh
sudo ./step-2-patch-acpi-table.sh
```

which will compile the fixed ACPI table, install it and reboot again.

5. Now on GRUB choose the patched kernel to boot from. If you see 
```
error: bad shim signature
error: you need to load the kernel first
```
you need to disable Secure Boot.

The speakers should now work.

### Special thanks

Thanks to [badgers-ua](https://github.com/badgers-ua/asus_zenbook_ux5304va_sound) for the source repository. I've only translated its README into bash scripts.
