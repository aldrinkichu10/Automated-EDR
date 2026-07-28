# Wazuh Manager Configuration Details

The following snippets document the custom threat intelligence and active response configurations added to the Wazuh Manager's `ossec.conf` file.

### 1. VirusTotal API Integration
This block configures Wazuh to send file hashes to VirusTotal whenever Syscheck (FIM) detects file modifications (Rules 550 and 554).

```xml
<integration>
  <name>virustotal</name>
  <api_key>YOUR_VIRUSTOTAL_API_KEY_HERE</api_key>
  <rule_id>550,554</rule_id>
  <alert_format>json</alert_format>
</integration>
```

### 2. Active Response Command Definitions
These blocks define the remediation commands and link them to the local scripts deployed on the Linux and Windows endpoints.

```xml
<!-- Command for Kali Linux -->
<command>
  <name>remove-threat</name>
  <executable>remove-threat.sh</executable>
  <timeout_allowed>no</timeout_allowed>
</command>

<!-- Command for Windows 11 -->
<command>
  <name>remove-threat-windows</name>
  <executable>remove-threat.cmd</executable>
  <timeout_allowed>no</timeout_allowed>
</command>
```

### 3. Active Response Triggers
These blocks instruct Wazuh to fire the remediation scripts immediately when VirusTotal returns a positive malicious match (Rule 87105).

```xml
<!-- Active Response Trigger for Kali -->
<active-response>
  <disabled>no</disabled>
  <command>remove-threat</command>
  <location>local</location>
  <rules_id>87105</rules_id>
</active-response>

<!-- Active Response Trigger for Windows -->
<active-response>
  <disabled>no</disabled>
  <command>remove-threat-windows</command>
  <location>local</location>
  <rules_id>87105</rules_id>
</active-response>
```
