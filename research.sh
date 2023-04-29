#!/bin/bash
#SBATCH -A research
#SBATCH -n 10
#SBATCH -w gnode081
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=4-00:00:00
#SBATCH --mail-type=END
#!/bin/bash

CKPT_PATH="ckpt_segan+"

# please specify the path to your G model checkpoint
# as in weights_G-EOE_<iter>.ckpt
G_PRETRAINED_CKPT="segan+_generator.ckpt"

# please specify the path to your folder containing
# noisy test files, each wav in there will be processed
TEST_FILES_PATH="data_veu4/expanded_segan1_additive/noisy_testset/"

# please specify the output folder where cleaned files
# will be saved




for d in /ssd_scratch/cvit/aparna/2/* ; do
    SAVE_PATH="/ssd_scratch/cvit/aparna/1_enhanced/$(basename $d)"
    python -u clean.py --g_pretrained_ckpt $CKPT_PATH/$G_PRETRAINED_CKPT \
    --test_files $d/noisy --cfg_file $CKPT_PATH/train.opts \
    --synthesis_path $SAVE_PATH --soundfile
done

#for d in /ssd_scratch/cvit/aparna/our_model/snr_minus_5/VGG_without_people/* ; do
#    SAVE_PATH="/ssd_scratch/cvit/aparna/synth_segan+/snr_minus_5/VGG_without_people/$(basename $d)"
#    python -u clean.py --g_pretrained_ckpt $CKPT_PATH/$G_PRETRAINED_CKPT \
#    --test_files $d/noisy --cfg_file $CKPT_PATH/train.opts \
#    --synthesis_path $SAVE_PATH --soundfile
#done

#for d in /ssd_scratch/cvit/aparna/our_model/snr_minus_10/VGG_without_people/* ; do
 #   SAVE_PATH="/ssd_scratch/cvit/aparna/synth_segan+/snr_minus_10/VGG_without_people/$(basename $d)"
  #  python -u clean.py --g_pretrained_ckpt $CKPT_PATH/$G_PRETRAINED_CKPT \
   # --test_files $d/noisy --cfg_file $CKPT_PATH/train.opts \
    #--synthesis_path $SAVE_PATH --soundfile
#done


