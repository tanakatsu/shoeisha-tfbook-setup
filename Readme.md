# Shoeisha tfbook sample setup

http://www.shoeisha.co.jp/book/download/9784798154121/detail

### Requirements

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- jq

### Get started

1. Create VM (GPU instance)
    - Don't forget to add network rules
      - open 80 (TCP) for jupyter notebook
      - open 6006 (TCP)  for TensorBoard
1. Edit `azure-env.sample.sh`
    - vmName
    - resourceGroup
    - privateKeyPath
1. Start VM
    ```
    $ azure-start
    ```
1. Login in VM
    ```
    $ azure-ssh
    ```
1.  Get Initialization script and run
    ```
    $ wget https://www.shoeisha.co.jp/static/book/download/9784798154121/init_script.sh
    $ sudo bash init_script.sh
    ```
1. Build docker image
    ```
    $ wget https://www.shoeisha.co.jp/static/book/download/9784798154121/Dockerfile
    $ sudo nvidia-docker build -t tfbook .
    ```
1. Get sample code
    ```
    $ sudo mkdir /notebooks
    $ cd /notebooks
    $ sudo wget https://www.shoeisha.co.jp/static/book/download/9784798154121/samples.zip
    $ sudo unzip samples.zip
    ```
1. Run jupyter notebook
    ```
    $ sudo nvidia-docker run --rm --name tfbook -p 80:8888 -p 6006:6006 -v /notebooks:/notebooks tfbook
    ```
1. Open notebook in browser

    Open url in your browser
    `http://VmInstanceIP/?token=TokenString`

### Shutdown VM and deallocate

Type `$ azure-stop`

### How to run jupyter notebook remotely without ssh login

First, start VM by `$ azure-start`.

Then,

In a terminal
```
$ azure-ip
$ azure-start-jupyter
```

In another terminal
```
$ azure-ip
$ ./azure-open-jupyter
```

