import os
import pandas as pd
from scipy.stats import chi2_contingency
from dotenv import load_dotenv

# Loading of Clean Dataset
load_dotenv()
file_path = os.getenv('BM_CLEAN')
df = pd.read_csv(file_path)

# Filtering to necessary columns for Chi-Square Test
f_df = df[['contact_group', 'y']]

# Building contingency table for the test
contingency_table = pd.crosstab(f_df['contact_group'], f_df['y'])

# Chi-Square Test
# Where:
# chi2 = chi square statistic
# p = p-value
# dof = degrees of freedom
# expected = expected values

chi2, p, dof, expected = chi2_contingency(contingency_table)

# Chi-Square Results
print("=" * 40)
print("   CHI-SQUARE TEST RESULTS")
print("=" * 40)
print(f"Chi-Square Statistic : {chi2:.4f}")
print(f"P-Value              : {p:.2e}")
print(f"Degrees of Freedom   : {dof}")
print("-" * 40)
print("Contingency Table:")
print(contingency_table)
print("-" * 40)
print("Expected Frequencies:")
print(pd.DataFrame(expected, 
      index=contingency_table.index, 
      columns=contingency_table.columns).round(2))
print("=" * 40)


