

# Graph-Theoretic Modeling and Simulation of Complex Polymer Structures

This repository contains the complete project for the study of *topologically complex polymers* using a combination of **graph theory** and **molecular dynamics (MD)** simulations.
The project is based on the paper *“Radius of gyration, contraction factors, and subdivisions of topological polymers”* by Cantarella et al. (2022, *J. Phys. A: Math. Theor. 55, 475202*), and aims to reproduce and analyze the relationship between polymer topology and structural compactness.

---

## Overview

Polymers with intricate topologies—such as stars, rings, trees, and leashes—exhibit diverse conformational behaviors that influence their physical properties.
This project explores these phenomena through two complementary components:

1. **Analytical Calculations** – Using graph-theoretic methods to determine asymptotic contraction factors.
2. **Molecular Dynamics Simulations** – Using LAMMPS to compute the radius of gyration numerically.

The analytical and simulation results are compared to validate theoretical predictions and to understand how molecular architecture affects polymer compactness and flexibility.

---

## Part I: Analytical Derivation

### Methodology

The analytical calculation is based on **Theorem 5** from Cantarella et al. (2022), which relates the asymptotic contraction factor ( g(G_\infty) ) to the trace of the pseudoinverse of the normalized Laplacian matrix:

[
g(G_\infty) = \frac{3}{e(G)^2} \left( \text{Tr}(L^+) + \frac{1}{3} \frac{l - 1}{6} \right)
]

Steps performed:

1. Constructed the **normalized Laplacian matrix (L)** for the molecular graph.
2. Computed **eigenvalues** (( \lambda_i )) and obtained the **Moore–Penrose pseudoinverse (L⁺)** via spectral decomposition.
3. Calculated the **trace of the pseudoinverse** ( \text{Tr}(L^+) = \sum 1/\lambda_i ).
4. Applied the formula for ( g(G_\infty) ) and compared the results with a reference tree polymer.

### Results Summary

| Quantity          | Molecule | Tree (Reference) |
| ----------------- | -------- | ---------------- |
| Vertices (v)      | 7        | 10               |
| Edges (e)         | 9        | 9                |
| Cycle Rank (l)    | 3        | 0                |
| Tr(L⁺)            | 9.5      | 16.5             |
| ( g(G_\infty) )   | 0.3827   | 0.6              |
| Relative g-factor | 0.6378   | –                |

The lower contraction factor for the cyclic polymer indicates higher compactness due to restricted flexibility.

---

## Part II: Molecular Dynamics Simulations

### Methodology

#### 1. Graph-Theoretic Representation

Each polymer topology is represented as a **graph**, where:

* **Nodes** correspond to monomer units.
* **Edges** represent chemical bonds.

The **normalized Laplacian matrix** captures the connectivity and spectral characteristics, serving as the foundation for both analytical and numerical analyses.

#### 2. LAMMPS Simulations

* Simulations are performed using **LAMMPS** to study polymer dynamics.
* Input data files define topology, bonding, and interaction parameters.
* Time evolution of the polymer structure is tracked to compute:

  * **Radius of gyration (Rg)**
  * **End-to-end distance**
* The contraction factor is calculated as the ratio of ( R_g^2 ) for the topological polymer to that of the reference tree polymer.

#### 3. Comparison and Validation

The numerically obtained contraction factors are compared with analytical values to evaluate the accuracy of graph-theoretic predictions.
This comparison validates the connection between polymer topology, Laplacian eigenvalues, and conformational compactness.

---

## References

Cantarella, J., Deguchi, T., Shonkwiler, C., & Uehara, E. (2022). *Radius of gyration, contraction factors, and subdivisions of topological polymers*.
**Journal of Physics A: Mathematical and Theoretical, 55(47), 475202.**
[https://doi.org/10.1088/1751-8121/aca300](https://doi.org/10.1088/1751-8121/aca300)

---
