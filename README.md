<h1 align="center">Docker Image for spinning up Jupyter notebook with relavent resources for Qauntum research and development</h1>
      
<p align="center">
  <a href="#about">About</a> •
  <a href="#credits">Credits</a> •
  <a href="#installation">Installation</a> •  
</p>

<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/HXH.png?raw=true" width="30%"></a>  
</h1>


## About
with the idea of the great @BoltzmannEntropy (Shlomo k.) i took the initiative to fork and a bit modify his work

The primary audience for this container can be any student or a researchers who that is willing to work on quantum computing tasks. 

The docker also includes several QML repositories with numerous examples:
 - https://github.com/theerfan/Q/tree/master/QML%20Course (A QML course in qiskit)
 - https://github.com/PaddlePaddle/Quantum.git (A QML course in Paddle-quantum)
 - https://github.com/DavitKhach/quantum-algorithms-tutorials.git
 - https://github.com/mit-han-lab/torchquantum.git
 - https://github.com/walid-mk/VQE.git 
 - https://github.com/MyEntangled/Quantum-Autoencoders.git
 - more to come...

# Quantum computing libraries, features etc 
<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/libs.png?raw=true" width="100%"></a>  
</h1>

 - Based on nvcr.io/nvidia/pytorch:21.07-py3
 - PyTorch 
 - PyTorchQuantum 
 - PennyLane 
 - Eigen3
 - Quantum++ and PyQPP
 - Qiskit
 - QuTip
 - Cirq 
 - Paddlepaddle
 - Paddle-quantum 
 - Tequila 
 - Qualacs
 - onnxruntime
 - Full LaTeX distribution
 - A passord protected Jupyter (password is:"mk2==2km") 
 - An SSH key that is embedded into the docker (change it of you want to)
 - Home directory /home/qmuser 
 - C++ compiler + CMake 
 
# Building
<h1 align="center">    
  <img src="https://github.com/BoltzmannEntropy/QMLDocker/blob/main/resources/logo.png?raw=true" width="30%"></a>  
</h1>

```bash
sudo docker build -t quantum .
```

# Running
```bash
sudo docker run -d --platform linux/amd64 -it --env="DISPLAY" -p 8097:7842 -v /tmp/.X11-unix:/tmp/.X11-unix:rw -e DISPLAY -e XAUTHORITY -v /Users/<your_user_name>/<workdir>:/home/qmuser/sharedfolder  quantum:latest bash
```

# Running
access the Jupyter notebook at 
http://<your_server_ip>::8097 <br>
password is ```mk2==2km```
