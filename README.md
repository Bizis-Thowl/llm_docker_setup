
# Setup LLM Self-hosting

## Prepare Docker Container

Initial package installations

```
apt-get update
apt-get install lshw
apt-get install nano
apt-get install curl
apt-get update && apt-get install -y libxcb1 libx11-6 libxext6 libxrender1 libgl1
curl -fsSL https://ollama.com/install.sh | sh
```

## Setup VLLM

Install uv for virtual environment management: \
`curl -LsSf https://astral.sh/uv/install.sh | sh` \
initialize virtual environment with compatible python version: \
`uv venv --python 3.12`\
Activate virtual environment:\
`source .venv/bin/activate`\
Install dependencies inside venv:\
`uv pip install vllm`


Enable .sh-file execution\
`chmod +x path/to/file/filename.sh`\
Start LLM\
`./path/to/file/filename.sh`\
Examples can be found here: `vllm_setup_files/`

## Setup OLLAMA

Pull Ollama model (from https://ollama.com/library?sort=newest):\
`ollama pull modelname`

Create with Modelfile (for additional parametrization):\
`ollama create <name> -f path/to/file/Modelfile`

Example for changing the context window with Modelfile:\
`ollama_files/Modelfile_example`

Serve with outside access:\
`OLLAMA_HOST=0.0.0.0:11434 ollama serve`\
Kill Process:\
`pkill ollama`