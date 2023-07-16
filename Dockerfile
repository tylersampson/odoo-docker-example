FROM odoo:16
USER root
RUN mkdir /mnt/3rdparty-addons && chown -R odoo:odoo /mnt/3rdparty-addons
COPY 3rdparty-addons /mnt/3rdparty-addons
RUN addons_path=$(find /mnt/3rdparty-addons -maxdepth 1 -type d ! -path "/mnt/3rdparty-addons" -printf ",%p") && \
    sed -i "s|addons_path = .*|addons_path = /mnt/extra-addons$addons_path|g" /etc/odoo/odoo.conf && \
    chown -R odoo /mnt/3rdparty-addons
COPY requirements.txt .
RUN pip install -r requirements.txt
USER odoo
EXPOSE 8069