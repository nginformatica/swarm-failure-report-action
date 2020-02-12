FROM appleboy/drone-ssh:1.5.5-linux-amd64

ADD entrypoint.sh /entrypoint.sh
ADD report-failures.sh /report-failures.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
