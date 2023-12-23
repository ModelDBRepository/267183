This MATLAB code is associated with the paper "Daily electrical activity in the master circadian clock of a diurnal mammal" by Beatriz Bano-Otalora, Matthew J Moye, Timothy Brown, Robert J Lucas, Casey O Diekman, Mino DC Belle. eLife 2021; 10:e68719
DOI: https://doi.org/10.7554/eLife.68179

It simulates a Hodgkin-Huxley-type model of the electrical activity of suprachiasmatic nucleus (SCN) neurons in the diurnal rodent Rhabdomys pumilio. Model parameters were inferred from current-clamp recordings using data assimilation (DA) algorithms available at https://github.com/mattmoye/neuroDA 

To reproduce Figure 4 (panels B, C, and D) of the paper, execute the script 'run_base_model_fig4BCD.m', which calls the function 'base_model'. This version of the model does not have a transient potassium current. Panel B is a voltage trace (with no applied current), panel C is a dV/dt vs V plot (with no applied current), and panel D is an F-I curve showing the firing rate over a range of applied currents.

To reproduce Figure 6 (panel O) of the paper, execute the script 'run_IA_model_fig4BCD.m', which calls the function 'IA_model'. It reads parameter values in from the file 'parameter_table_rhabdomys_10_28_21.xlsx'. This version of the model does have a transient potassium current. Panel i is a voltage trace with full I_A, panel ii is a voltage trace with reduced I_A, and panel iii is a voltage trace with no I_A, showing that the delay to fire following the hyperpolarizing current pulse is dependent on the A-current.

To simulate other versions of the model shown in the paper, set parameter values according to the table shown in Supplementary file 1 or by selecting the appropriate column in the 'parameter_table_rhabdomys_10_28_21.xlsx' file.



