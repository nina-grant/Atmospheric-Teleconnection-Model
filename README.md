# Getting Set-up in Amarel

## Connect to Amarel
1. Open a terminal:
    - **Macs**: Open a terminal.
    - **Windows**: Use MobaXTerm or VSCode.
2. Connect to Amarel:
    ```bash
    ssh user@amarel.rutgers.edu
    ```

## Login to a Compute Node
```bash
srun --partition=main --mem=10000 --time=03:00:00 --pty bash
```

## Setting Up Conda Environment

### Note on Nodes
- **Login Node**: The initial node you connect to; used for data transfer, software building, and job preparation.
- **Compute Nodes**: Use these for running jobs to avoid impacting other users on the shared login node.

### Create Your Conda Environment
1. Load necessary modules:
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
3. Create directories for Conda environments:
    ```bash
    mkdir -p .conda/pkgs/cache .conda/envs
    ```
4. Create and activate your Conda environment:
    ```bash
    conda create -n PyGCM
    conda activate PyGCM
    ```
5. Install necessary packages:
    ```bash
    conda install -c conda-forge esmpy
    pip install torch xarray numpy matplotlib netcdf4 pydap h5netcdf scipy xesmf dask cartopy pandas dask[distributed] torch_harmonics metpy
    conda install -c conda-forge ipykernel
    python -m ipykernel install --user --name=PyGCM
    ```

## Open Jupyter Notebook
### From Terminal
```bash
jupyter notebook
```
### OnDemand
- Go to: [OnDemand](https://ondemand.hpc.rutgers.edu/)

### HPC
- Go to: [Amarel HPC](https://amarel.hpc.rutgers.edu:3443/)

### VSCode
- Click `preprocess.ipynb`

## OnDemand Walkthrough
1. Run `preprocess.ipynb`.
2. Navigate to `/scratch` or `/home` directory.
3. Create new folders for model files and output.
4. Open `preprocess.ipynb` and select the new environment by changing the kernel.
5. Recommended to work in `/scratch` and transfer final files to `/home`.

## Recommended Workflow
1. Create a new folder for each experiment within `/scratch/$USER/Model`.
2. Copy default versions of `preprocess`, `RunModel`, `subs1_util` into the new folder.
3. Make edits and run `preprocess` to generate input files.
4. Edit `RunModel` and generate a `.py` version.
5. Run `sbatch` script, save the job ID, and log files.
6. Postprocess output (e.g., convert sigma to pressure).

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


