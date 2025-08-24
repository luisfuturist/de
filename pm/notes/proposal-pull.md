# **Project Proposal: File Pulling Script**

This document outlines a proposal for a bash script, tentatively named de pull, designed to streamline the process of pulling files. The goal is to provide a reliable and user-friendly tool to manage changes between a destination directory and a "src" directory.

## **Core Functionality**

The script will copy the files include in the \`.deinclude\` from the destination (e.g. /home/luis/.gitconfig) the source (src/files/home/luis/.gitconfig), overwriting existing files or creating new ones as needed.

## **Special Considerations**

### **.deinclude File**

The script will check for a .deinclude file, which acts as an allowlist for pulling. If this file exists, the script will only conside and pull the files that are explicitly mentioned within it.

### **Handling Empty or Missing .deinclude**

If the .deinclude file is missing or empty, the script will immediately stop execution. It will print a clear message informing the user that the file is empty or missing and will suggest generating a new one by running the de freeze command, which would create a .deinclude file based on the full structure of the src/files directory.