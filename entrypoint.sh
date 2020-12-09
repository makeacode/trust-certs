#!/bin/sh -x

whoami

cd /output

cp "${JAVA_HOME}/jre/lib/security/cacerts" . 

chmod 0644 cacerts

ls -l

# import additional root certificates
for filename in /trust-certs/*; do
  if ! keytool -list -keystore 'cacerts' -storepass 'changeit' \
                -alias "`basename $filename`" > /dev/null; then

    keytool -noprompt -import -trustcacerts \
            -keystore 'cacerts' -storepass 'changeit' \
            -alias "`basename $filename`" -file "$filename"
  fi
done


