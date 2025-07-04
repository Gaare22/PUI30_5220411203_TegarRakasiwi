import pandas as pd

def hitung_likelihood(jumlah, total, m=5):
    return round((jumlah + 1) / (total + m), 6)

def generate_likelihood_table_from_df(df):
    Real_Target_list = df['Real_Target'].unique()
    total_per_Real_Target = {k: len(df[df['Real_Target'] == k]) for k in Real_Target_list}
    total_data = len(df)
    m = 5  # jumlah kategori (1–5)

    likelihood = {}

    for p in [f'P{i}' for i in range(1, 16)]:
        likelihood[p] = {}
        for nilai in range(1, 6):
            likelihood[p][nilai] = {}
            for k in Real_Target_list:
                count = len(df[(df[p] == nilai) & (df['Real_Target'] == k)])
                total = total_per_Real_Target[k]
                prob = hitung_likelihood(count, total, m)
                likelihood[p][nilai][k] = prob

    prior_prob = {k: round(total_per_Real_Target[k] / total_data, 6) for k in Real_Target_list}

    return likelihood, prior_prob, total_per_Real_Target, total_data