echo "fields_under_root: true
fields: {system.service: ""gw"", system.name: ""$(hostname)"", system.pri_ip: ""$((Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ne 'Loopback Pseudo-Interface 1' }).IPAddress)"", system.pub_ip: ""$(Invoke-RestMethod http://ipinfo.io/ip)""}

winlogbeat.event_logs:
  - name: Application
    tags: [""windows_evt_application""]
  - name: Security
    tags: [""windows_evt_security""]
  - name: System
    tags: [""windows_evt_system""]
  - name: Setup
    tags: [""windows_evt_setup""]

processors:
  - add_host_metadata: ~
  - add_cloud_metadata: ~

logging.to_files: true
logging.files:
  path: C:/ProgramData/winlogbeat/Logs
logging.level: info

output.logstash:
  hosts: [""elk-private.joycityglobal.com:5044""]" > "C:/joycity-system/winlogbeat/winlogbeat.yml"

net stop winlogbeat
net start winlogbeat
