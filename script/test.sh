#!/bin/bash
#SBATCH --job-name=ood_detection_contrastive
#SBATCH --account=project_2009557
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
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

python -m torch.distributed.launch --nproc_per_node=1 --master_port=48798 /scratch/project_2009557/Boyi_zheng/course/short-term_course/Foundation_model_retinal_disease/RETFound_MAE_直接调用/main_finetune.py \
    --model vit_large_patch16 \
    --eval \
    --global_pool \
    --batch_size 16 \
    --world_size 1 \
    --epochs 100 \
    --blr 5e-3 --layer_decay 0.65 \
    --weight_decay 0.05 --drop_path 0.2 \
    --nb_classes 5 \
    --data_path "/scratch/project_2009557/APTOS2019" \
    --input_size 224 \
    --task ./finetune_APTOS2019/ \
    --resume ./finetune_APTOS2019/checkpoint-best.pth \
    --task 'aptos'