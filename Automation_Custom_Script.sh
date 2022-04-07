. /boot/dietpi/func/dietpi-globals

# Set WiFi Country Code
/boot/dietpi/func/dietpi-set_hardware wificountrycode "$(sed -n '/^[[:blank:]]*AUTO_SETUP_NET_WIFI_COUNTRY_CODE=/{s/^[^=]*=//p;q}' /boot/dietpi.txt)"

# Uninstall OpenSSH Client
/boot/dietpi/dietpi-software uninstall 0

# Remove unused services
G_EXEC rm /etc/systemd/system/dietpi-vpn.service
G_EXEC rm /etc/systemd/system/dietpi-cloudshell.service

# Configure RTC Module
G_AGP fake-hwclock
G_CONFIG_INJECT "dtoverlay=i2c-rtc,ds3231" "dtoverlay=i2c-rtc,ds3231" /boot/config.txt
G_EXEC sed -i "/systemd/,/fi/s/^/#/" /lib/udev/hwclock-set
G_EXEC sed -i "/--systz/s/^/#/" /lib/udev/hwclock-set

# Install packages
G_AGI telegraf
G_EXEC pip3 install -r /boot/sailtrack/requirements.txt

# Enable services
G_CONFIG_INJECT "+ telegraf" "+ telegraf" /boot/dietpi/.dietpi-services_include_exclude
G_CONFIG_INJECT "+ sailtrack-lora2mqtt" "+ sailtrack-lora2mqtt" /boot/dietpi/.dietpi-services_include_exclude
G_EXEC /boot/dietpi/dietpi-services dietpi_controlled telegraf
G_EXEC /boot/dietpi/dietpi-services dietpi_controlled sailtrack-lora2mqtt

# Configure DietPi Banner
settings=(1 1 1 0 0 1 0 1 0 0 0 0 0 0 0 0)
for i in "${!settings[@]}"; do
  G_CONFIG_INJECT "aENABLED\[$i]=" "aENABLED[$i]=${settings[$i]}" /boot/dietpi/.dietpi-banner
done

# Reboot after first boot is completed
(while [ -f "/root/AUTO_CustomScript.sh" ]; do sleep 1; done; /usr/sbin/reboot) > /dev/null 2>&1 &
