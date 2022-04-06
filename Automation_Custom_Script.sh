. /boot/dietpi/func/dietpi-globals

# Set WiFi Country Code
/boot/dietpi/func/dietpi-set_hardware wificountrycode "$(sed -n '/^[[:blank:]]*AUTO_SETUP_NET_WIFI_COUNTRY_CODE=/{s/^[^=]*=//p;q}' /boot/dietpi.txt)"

# Uninstall OpenSSH Client
dietpi-software uninstall 0

# Configure RTC Module
G_AGP fake-hwclock
G_CONFIG_INJECT "dtoverlay=i2c-rtc,ds3231" "dtoverlay=i2c-rtc,ds3231" /boot/config.txt
G_EXEC sed -i "/systemd/,/fi/s/^/#/" /lib/udev/hwclock-set
G_EXEC sed -i "/--systz/s/^/#/" /lib/udev/hwclock-set

# Install packages
G_AGI telegraf
G_EXEC pip3 install -r /boot/sailtrack/requirements.txt

# Enable services
for s in /etc/systemd/system/sailtrack*.service; do
  servicename=$(basename "$s" .service)
  G_CONFIG_INJECT "+ $servicename" "+ $servicename" /boot/dietpi/.dietpi-services_include_exclude
  /boot/dietpi/dietpi-services dietpi_controlled "$servicename"
done

# Configure DietPi Banner
settings=(1 1 1 0 0 1 0 1 0 0 0 0 0 0 0 0)
for i in "${!settings[@]}"; do
  echo "aENABLED[$i]=${settings[$i]}" >> /boot/dietpi/.dietpi-banner
done

# Reboot after first boot is completed
(while [ -f "/root/AUTO_CustomScript.sh" ]; do sleep 1; done; /usr/sbin/reboot) > /dev/null 2>&1 &
