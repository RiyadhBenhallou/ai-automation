# 🧠 Langflow OSS Setup Guide (Linux/macOS)

This guide explains how to install and run the **Langflow OSS Python package** using `uv` in a virtual environment on Linux or macOS.

---

## 📋 Prerequisites

Before you begin, make sure you have the following installed:

### 🐍 Python

- Version **3.10 → 3.13**

### ⚙️ Additional Tools

- **[uv](https://github.com/astral-sh/uv)** — for fast virtual environment and package management.
- **Sufficient infrastructure:**
  - **Minimum:** Dual-core CPU, 2 GB RAM
  - **Recommended:** Multi-core CPU, 4 GB+ RAM

---

## 🧩 Step 1: Create a Virtual Environment

Virtual environments keep your Langflow installation isolated from other Python projects.

Navigate to the directory where you want your environment, then create it:

```bash
uv venv VENV_NAME
Replace VENV_NAME with your preferred environment name.

Activate the environment:

bash
Copy code
source VENV_NAME/bin/activate
You should see your shell prompt change:

scss
Copy code
(VENV_NAME) ➜  langflow git:(main) ✗
To deactivate:

bash
Copy code
deactivate
To delete the environment:

bash
Copy code
rm -rf VENV_NAME
📦 Step 2: Install Langflow
With your virtual environment activated, install Langflow via uv:

bash
Copy code
uv pip install langflow
To install a specific version:

bash
Copy code
uv pip install langflow==1.4.22
To reinstall or upgrade Langflow:

bash
Copy code
uv pip install --upgrade langflow
🚀 Step 3: Run Langflow
Start the Langflow server:

bash
Copy code
uv run langflow run
⏳ It may take a few minutes to start the first time.

Once running, open your browser and visit:
👉 http://127.0.0.1:7860

🧠 Next Steps
Create your first flow by following the Langflow Quickstart tutorial inside the app.

🧹 Summary
Command	Description
uv venv VENV_NAME	Create a virtual environment
source VENV_NAME/bin/activate	Activate the environment
deactivate	Exit the environment
uv pip install langflow	Install Langflow
uv run langflow run	Start Langflow locally

Enjoy building with Langflow!
```
