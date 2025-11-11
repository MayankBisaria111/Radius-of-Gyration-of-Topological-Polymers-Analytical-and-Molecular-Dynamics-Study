
# **Analytical Calculation of the Radius of Gyration and Contraction Factor**

### **Course:** ChE 209 – Molecular Simulation and Modelling

### **Project:** Radius of Gyration of Topological Polymers

### **Based on:** *Cantarella et al. (2022),* J. Phys. A: Math. Theor. 55, 475202

[https://doi.org/10.1088/1751-8121/aca300]([https://doi.org/10.1088/1751-8121/aca300](https://iopscience.iop.org/article/10.1088/1751-8121/aca300))

---

## **Overview**

This repository contains the **Analytical Component** of the project *“Radius of Gyration of Topological Polymers.”*
The project aims to reproduce the analytical results of Cantarella *et al.* (2022) for a specific polymer topology using **graph theory**. The calculation focuses on determining the **asymptotic contraction factor** (*g-factor*) and the **radius of gyration** of the assigned polymer structure.

This work constitutes **Part I (Analytical)** of the two-part project:

1. **Analytical Derivation** – Based on graph-theoretical methods.
2. **Molecular Dynamics (MD) Simulations** – Conducted separately using LAMMPS.

---

## **Analytical Methodology**

The analytical derivation follows **Theorem 5** from the paper, which relates the asymptotic contraction factor ( g(G_\infty) ) to the **trace of the pseudoinverse of the normalized Laplacian matrix**:

[
g(G_\infty) = \frac{3}{e(G)^2} \left( \text{Tr}(L^+) + \frac{1}{3} \frac{l - 1}{6} \right)
]

### **Steps Performed:**

1. **Constructed the normalized Laplacian matrix (L)** for the assigned molecular graph.
2. **Computed eigenvalues** (( \lambda_i )) and the **Moore–Penrose pseudoinverse (L⁺)** using spectral decomposition.
3. **Calculated the trace** ( \text{Tr}(L^+) = \sum 1/\lambda_i ) for all nonzero eigenvalues.
4. **Applied Theorem 5** to obtain ( g(G_\infty) ).
5. **Compared results** with a reference tree polymer to compute the **relative contraction factor**.

---

## **Key Results**

| Quantity          | Molecule   | Tree (Reference) |
| ----------------- | ---------- | ---------------- |
| Vertices (v)      | 7          | 10               |
| Edges (e)         | 9          | 9                |
| Cycle Rank (l)    | 3          | 0                |
| Tr(L⁺)            | 9.5        | 16.5             |
| ( g(G_\infty) )   | 0.3827     | 0.6              |
| Relative g-factor | **0.6378** | –                |

---

## **Conclusion**

The analytical calculation yields ( g(G_\infty) = 0.3827 ) for the assigned polymer, indicating higher compactness compared to a linear (tree) polymer due to cyclic constraints.
This analysis validates the **graph-theoretical approach** to predicting polymer conformational properties.

---

