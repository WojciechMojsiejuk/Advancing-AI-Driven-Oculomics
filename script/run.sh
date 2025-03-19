#!/bin/bash
#SBATCH --job-name=ood_detection_contrastive
#SBATCH --account=project_2009557
#SBATCH --partition=gpusmall
#SBATCH --time=06:15:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
## if local fast disk on a node is also needed, replace above line with:
#SBATCH --gres=gpu:a100:1,nvme:900
#
## Please remember to load the environment your application may need.
## And use the variable $LOCAL_SCRATCH in your batch job script 
## to access the local fast storage on each node.

$LOCAL_SCRATCH
export PATH="/projappl/project_2009557/conda/RETFound/bin:$PATH"
# for i in {1..4}
# do
#     echo "Running iteration $i"
#     # 在这里放置你要运行的命令
#     python -m torch.distributed.launch --nproc_per_node=1 --master_port=48788 /projappl/project_2009557/Foundation_model_retinal_disease/RETFound_MAE_直接调用/main_finetune.py \
#     --batch_size 8 \
#     --world_size 1 \
#     --model vit_large_patch16 \
#     --epochs 50 \
#     --blr 5e-3 \
#     --layer_decay 0.65 \
#     --weight_decay 0.05 \
#     --drop_path 0.2 \
#     --nb_classes 3 \
#     --data_path "/scratch/project_2009557/Glaucoma_fundus" \
#     --task ./finetune_Glaucoma_fundus/ \
#     --finetune /projappl/project_2009557/Foundation_model_retinal_disease/RETFound_cfp_weights.pth \
#     --input_size 224
# done

python /projappl/project_2009557/Foundation_model_retinal_disease/RETFound_MAE_直接调用/metric_calculate.py