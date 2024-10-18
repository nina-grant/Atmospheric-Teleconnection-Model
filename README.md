# Getting Set-Up in Amarel

## Connect to Amarel
1. Open a terminal:
    - **Macs**: Open a terminal.
    - **Windows**: Use MobaXTerm or VSCode.
      
2. Connect to the Amarel virtual machine:
    ```bash
    ssh user@amarel.rutgers.edu
    ```
### Off-Campus?
If you are not on campus and connected to the Rutgers wifi, you will have to download Cisco Secure Client and connect to the Rutgers VPN before you can ssh to Amarel.
Find instructions for setting up the VPN here: [Rutgers VPN](https://it.rutgers.edu/virtual-private-network/)

## Login to a Compute Node
```bash
srun --partition=main --mem=10000 --time=03:00:00 --pty bash
```

### *A Note on Nodes*
- **Login Nodes**: The initial node you connect to. There can often be over 100 users connected to one login node at one time.
- **Compute Nodes**: ***ALWAYS*** use these for running jobs to avoid impacting other users on the shared login node. Running applications on a shared login node or doing things that consume significant compute, memory, or network resources can unfairly impact other users.

## Create Your Conda Environment
1. Load the necessary modules to define our own custom environments:
    ```bash
    module use /projects/community/modulefiles/
    module load anaconda/2020.07-gc563
    ```
2. Initialize Conda for bash:
    ```bash
    conda init bash
    cd
    source .bashrc
    ```
3. Add path to the environment:
   ```bash
   conda config --add envs_dirs /projects/community/miniconda3/envs
   ```
   Run `conda env list` to confirm the environment paths loaded.
5. Activate the environment PyGCM
    ```bash
   conda activate PyGCM
    ```
    Try specifying the full path if that doesn't work: `conda activate /projects/community/miniconda3/envs/PyGCM`
7. Install necessary packages:
    ```bash
    python -m ipykernel install --user --name=PyGCM
    ```

## Open Jupyter Notebook
See Amarel's walkthrough video on the different ways to access and interact with Amarel:
[Intro to the Amarel Cluster](https://rutgers.mediaspace.kaltura.com/channel/OARC-Intro-to-the-Amarel-Cluster)


### OnDemand
- Go to: [OnDemand](https://ondemand.hpc.rutgers.edu/)

### HPC
- or Go to: [Amarel HPC](https://amarel.hpc.rutgers.edu:3443/)

### VSCode
- or Click `preprocess.ipynb`

## OnDemand Walkthrough
Go to `Interactive Apps` then `Personal Jupyter` 
![screenshot](./images/Screenshot%202024-10-11%20130054.png)

Choose how many hours you need. You can request 2 CPUs and 10 GB of memory. You can also select the partition `p_sebs_1`, but this isn't necessary at this stage.
![screenshot](./images/Screenshot%202024-10-11%20130348.png)

Change the conda path to: `/home/$USER/miniconda3`, replacing $USER with your ID. Type `base` for your environment.
![screenshot](./images/Screenshot%202024-10-18%20145714.png)

You'll then be taken to this next page. Wait for the resources to be assigned. When the button appears, connect to your new job.
![screenshot](./images/Screenshot%202024-10-11%20130622.png)

Navigate to the `/scratch` folder by clicking the folder symbol. Find your username.
![screenshot](./images/Screenshot%202024-10-11%20131520.png)

## Run `preprocess.ipynb`
1. Navigate to your `/scratch` or `/home` directory.
   - It's recommended to work in `/scratch` and transfer your final files to `/home` when you're done.
2. Create new folders for the model files and the output files.
3. Download the model files from [GitHub](./MultiThread_Model).
4. Upload the PyGCM files to your new `/Model` folder.
5. Open `preprocess.ipynb` and select the PyGCM environment by changing the kernel, if needed.

### A note on directories
- Your personal /home directory is in /home/<NetID>. You have 100 GB of backed-up storage there.
- Your temporary /scratch directory is in /scratch/<NetID>. You have 1 TB of space there.
- /scratch is the best location for running your jobs because you have more space than in your /home directory and you can have multiple jobs or tasks concurrently reading and writing. The trade-off for performance and extra space in this directory is that nothing in the /scratch directory is backed up. If you delete files in your /scratch directory, they cannot be recovered. 

## Recommended Workflow
1. Create a new folder for each experiment within `/scratch/$USER/Model`. (Try to use descriptive and specific names).
2. Copy the default versions of `preprocess`, `RunModel`, and `subs1_util` into the new experiment folder.
3. Make your edits and run `preprocess` to generate the input files.
4. Edit `RunModel` and generate a `.py` version:

   Ex: `jupyter nbconvert --to script /scratch/$USER/Model/RunModel.Total.ipynb --output RunModelConverted`

   You can run it with or without the --output option and name the output file whatever you want. The default without the `--output` flag is to keep the same name and only change the file type.
6. Modify and run the `sbatch` script. Change the username and the paths for the input folder and log file.
7. Save the job ID# for future reference and troubleshooting.
8. Postprocess the output (e.g., convert sigma to pressure).

##
Also see the creator's workflow instructions below. The instructions above have been modified for use on Amarel.

[Link to the original repository](https://github.com/jsb288/Atmospheric-Teleconnection-Model)

## Helpful Commands
- **Check storage usage**: 
    ```bash
    mmlsquota --block-size=auto scratch
    ```
- **Check job status**: 
    ```bash
    squeue -u <NetID>
    ```
- **Confirm job resources**: 
    ```bash
    scontrol show job [JOBID]
    ```
- **Check past jobs**: 
    ```bash
    sacct
    ```
- **Check past memory usage**: 
    ```bash
    sacct --units=G --format=MaxRSS,MaxDiskRead,MaxDiskWrite,Elapsed,NodeList -j [JOBID]
    ```
- **Cancel job**: 
    ```bash
    scancel [JOBID]
    ```

## Amarel Resources
- [Welcome to Amarel](https://sites.google.com/view/cluster-user-guide/amarel/welcome)
- [Cluster Guide](https://sites.google.com/view/cluster-user-guide#h.q5kh60n6t6zy)
- [Accessing Amarel Video Tutorial](https://rutgers.mediaspace.kaltura.com/channel/OARC-Intro-to-the-Amarel-Cluster)



# Atmospheric Teleconnection Model

## Getting Started (Installation):

1) Install the project from Github  
Click the green "<>Code" button, click "Download ZIP", find the project in your downloads, and unzip the folder (extract all). You can move the entire Atmosperic-Teleconnection-Model folder, but moving individual files within that folder may cause problems if all scripts' folder path variables are not changed accordingly.

2) Make sure you have the correct environment  
The Environments folder includes yml files you can use to create a python environment for the project. For more on creating a conda environment from a yml file, refer to the [Conda User Guide](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-from-an-environment-yml-file). Use the agcm_environment_windows.yml file for environments on Windows machines or the agcm_environment_mac.yml file for MAC machines. agcm_environment.yml is a generic version which can be used for either.

3) Edit Preprocess.ipynb variables  
Edit Preprocess.ipynb to choose your resolution, number of months to run, and make sure your folder paths are correctly set - that is, where to write the output. Documentation in the notebooks should help in doing this.

4) Run Preprocess.ipynb as a jupyter notebook  
You can easily modify the topography, background state or the heating in this script, but we suggest running without modification first.

5) Edit RunModel.beta.ipynb (or RunModel.PrescribedMean.ipynb) variables  
Choose which model you are using and edit its variables according to your requirements. Variables included in both postprocess and the model must match.

6) Run RunModel.beta.ipynb (or RunModel.PrescribedMean.ipynb)  
The RunModel.beta.ipynb file is the weakly prescribed mean version and the RunModel.PrescribedMean.ipynb file is the strongly prescribed mean version of the model. See manuscript for detailed discussion of the two versions of the model.

7) Edit and run a Postprocess script  
Before running the postprocess file, edit the variables to match your data from the preprocess and model files. There are two post-processing scripts in the Postprocess folder for vertical interpolation for sigma to pressure coordinates. The preferred post-processing uses metpy as indicated in the filename. The raw model output is in the native sigma coordinate in the vertical and is on the Gaussian grid for the horizontal.

8) Issues, questions or concerns please contact Ben Kirtman at bkirtman@miami.edu.
