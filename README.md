# 🛡️ Automated Endpoint Detection and Response (EDR) Pipeline

## 📌 Executive Summary

In modern Security Operations Centers (SOC), the mean time to respond (MTTR) to a threat is a critical metric. This project demonstrates a fully functional, cross-platform Automated Endpoint Detection and Response (EDR) pipeline. By integrating Wazuh (SIEM/XDR) with the VirusTotal API, this architecture autonomously detects malicious file activity, enriches the alert with global threat intelligence, and executes automated remediation scripts to neutralize threats in real-time across both Windows and Linux environments without requiring manual analyst intervention.

## ⚙️ System Architecture & Threat Lifecycle

The pipeline operates on a continuous loop of monitoring, analysis, and active response:

1. **Continuous Endpoint Monitoring (Detection):** Wazuh agents deployed on target endpoints (Windows and Linux) utilize File Integrity Monitoring (FIM) and real-time behavioral analysis to detect the creation or modification of suspicious files.
2. **Threat Intelligence Enrichment (Analysis):** Upon detection, the Wazuh Manager automatically extracts the file hash (MD5/SHA256) and queries the VirusTotal API. This provides real-time threat intelligence to determine if the file is a known indicator of compromise (IoC).
3. **Automated Triage (Alerting):** If VirusTotal returns a positive malicious hit threshold, Wazuh classifies the event as a critical security incident and logs the detailed alert within the centralized SIEM dashboard.
4. **Automated Remediation (Active Response):** Triggered by the critical alert, the Wazuh Manager pushes a command back to the specific endpoint agent to execute a custom remediation script. The script forcefully isolates or deletes the malicious file, neutralizing the threat instantly.

## 🛠️ Technical Stack & Tooling

* **SIEM / XDR:** Wazuh
* **Threat Intelligence:** VirusTotal API
* **Target Environments:** Windows 11 / Windows 10, Kali Linux
* **Scripting & Automation:**
  * Bash (`.sh`) for Linux remediation
  * PowerShell (`.ps1`) and Command Prompt (`.cmd`) for Windows remediation

## ⚙️ Wazuh Manager Configuration

The custom threat intelligence (VirusTotal) integrations and active response rules used in this pipeline are fully documented here:
👉 **[View Wazuh Configuration Details](wazuh-configuration.md)**

## 💻 Active Response Scripts

* `remove-threat.sh`: Active Response script for Kali Linux endpoints.
* `remove-threat.cmd`: Active Response script for Windows 11 endpoints.
* `remove-threat.ps1`: PowerShell alternative for Windows environments.

## 📸 Proof of Concept (PoC)

### Windows 11 Automated Remediation
![Windows PoC](windows-cmd.png)

### Kali Linux Automated Remediation
![Kali PoC](kali.png)
