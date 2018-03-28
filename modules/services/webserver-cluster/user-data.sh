#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World -- Update</h1>
<p>Address: ${db_address}</p>
<p>Port: ${db_port}</p>
EOF

nohup busybox httpd -f -p "${server_port}" &
