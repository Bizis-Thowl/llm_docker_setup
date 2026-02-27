
# Setup LLM Self-hosting

## Initialize Docker Container

> :warning: **Note:** If you are using Ollama, you can also run a dedicated Ollama-Container. More on that in "Dedicated Ollama Container"

```
sudo docker run -it --name <container_name> --gpus='"device=<index>"' -p <outbound>:<inbound> nvidia/cuda:12.8.0-cudnn-devel-ubuntu24.04
```

Descriptions\
`device=5` takes the GPU with index 5 Check different GPU load via `nvidia-smi`\
`-p 11876:11434` -> `outbound-port:inbound-port`: Wenn im Container ein LLM auf Port 11434 läuft, kann es von außerhalb des Containers via Port 11876 angesprochen werden.

## Prepare Docker Container

Initial package installations

```
apt-get update
apt-get install lshw
apt-get install nano
apt-get install curl
(apt-get install git) <-- If you want to clone this repo
apt-get install -y libxcb1 libx11-6 libxext6 libxrender1 libgl1
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

install:\
`curl -fsSL https://ollama.com/install.sh | sh`

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

## Dedicated Ollama-Container

It is also possible to run an ollama Docker image. To do so run the following command (Make sure to replace the names in the <>-brackets with your own):

``
sudo docker run --gpus "device=<gpu-index>" --name <container-name> -it --rm -p <port-number>:<port-number> ollama/ollama
``

| name | purpose |
|---|---|
| `<gpu-index>` | Indicates the index (e.g. 3) of the GPU that shoul be used. Make sure to check for the different GPU loads via `nvidia-smi`. |
| `<container-name>` | A name for your container. Useful for working with the container and to stop it from running. |
| `<port-number>` | The port number under which your container can be reached from the network. |

After running your container you need to open a shell within the container. You can do that by running ``sudo docker exec -it <container-name> sh``

Inside the container you can run your model by ``ollama run <model-name>``. Ollama will then open a shell for your model which you can leave with ``/bye``. After that you can run ``OLLAMA_HOST=0.0.0.0:<port-number> ollama serve`` to make your model accessible from the outside

After finishing your work with a container, you can stop your docker-container with
``
docker stop <container-name>
``

## Test from outside

Example (server_url:port/v1/models):\
List running models on Port: http://hal9000.skim.th-owl.de:11876/v1/models