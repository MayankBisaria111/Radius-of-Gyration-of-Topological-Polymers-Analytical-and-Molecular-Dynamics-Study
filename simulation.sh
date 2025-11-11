#!/bin/bash
#SBATCH --job-name=polymer_sim
#SBATCH --output=polymer_sim.out
#SBATCH --error=polymer_sim.err
#SBATCH --ntasks=1
#SBATCH --time=10:00:00
#SBATCH --partition=phd_student
#SBATCH --qos=phd_student

# -------------------- Environment Setup --------------------
source /apps/compilers/intel/oneapi/setvars.sh
module load lammps-cpu
module load anaconda3

cd "$SLURM_SUBMIT_DIR"

# -------------------- Parameters --------------------
DT=0.005
NSTEPS=1000000
LANGV_SEED=12345

TREE_DIR="tree_sim"
LEASH_DIR="leash_sim"
RESULT_DIR="results_polymer"

# -------------------- Step 1: Generate Polymer Data --------------------
echo "=== Step 1: Generating polymer data files ==="
python gen_tree_polymer.py ${TREE_DIR}
python gen_leash_polymer.py ${LEASH_DIR}

if [[ ! -f tree.data ]] || [[ ! -f leash.data ]]; then
    echo "❌ Data generation failed!"
    exit 1
fi
echo "✅ Polymer data files generated."

# -------------------- Step 2: Run LAMMPS Simulations --------------------
echo "=== Step 2: Running LAMMPS simulations ==="

# Prepare clean directories
rm -rf ${TREE_DIR} ${LEASH_DIR}
mkdir -p ${TREE_DIR} ${LEASH_DIR}

# --- Tree Simulation ---
mv tree.data ${TREE_DIR}/
cp inp_tree.txt ${TREE_DIR}/

cd ${TREE_DIR}
echo "→ Running TREE simulation..."
mpirun -np 1 /apps/codes/lammps/cpu/bin/lmp_oneapi -in inp_tree.txt
cd ..

# --- Leash Simulation ---
mv leash.data ${LEASH_DIR}/
cp inp_leash.txt ${LEASH_DIR}/

cd ${LEASH_DIR}
echo "→ Running LEASH simulation..."
mpirun -np 1 /apps/codes/lammps/cpu/bin/lmp_oneapi -in inp_leash.txt
cd ..

# -------------------- Step 3: Post-processing --------------------
echo "=== Step 3: Calculating Rg difference ==="

rm -rf temp_rg
mkdir temp_rg
cp ${TREE_DIR}/rg_tree.txt temp_rg/
cp ${LEASH_DIR}/rg_leash.txt temp_rg/

cd temp_rg
python ../cal_g.py
cd ..

# -------------------- Step 4: Organize Results --------------------
echo "=== Step 4: Organizing results ==="
rm -rf ${RESULT_DIR}
mkdir ${RESULT_DIR}
mv ${TREE_DIR} ${LEASH_DIR} temp_rg/rg_difference.txt ${RESULT_DIR}/ 2>/dev/null

echo "🎯 All polymer simulations and analysis completed successfully!"
echo "📁 Results are stored in: ${RESULT_DIR}/"
