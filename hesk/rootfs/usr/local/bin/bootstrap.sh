#!/bin/bash

if [ ! -f /var/www/html/hesk_settings.inc.php ]; then
    unzip /src/hesk/hesk${HESK_VERSION}.zip -d /var/www/html
    unzip /src/hesk/it.zip -d /var/www/html/language
    chown -Rv www-data:www-data /var/www/html
fi

exec /usr/local/bin/apache2-foreground
