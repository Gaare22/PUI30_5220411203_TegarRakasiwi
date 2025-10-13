def generate_likelihood_table_from_df(df, jurusan_decode=None, jenis_kelamin_decode=None):
    kelas_unik = df['real_target'].unique()
    total_data = len(df)
    total_per_kelas = df['real_target'].value_counts().to_dict()
    prior_prob = {k: total_per_kelas[k] / total_data for k in total_per_kelas}


    # --- Likelihood Jenis Kelamin ---
    jenis_kelamin_rows = []
    if 'jenis_kelamin' in df.columns:
        kategori = df['jenis_kelamin'].dropna().unique()
        for val in kategori:
            decoded_val = jenis_kelamin_decode.get(val, val) if jenis_kelamin_decode else val  # decode di sini
            row = {"Pilihan": decoded_val}
            for k in kelas_unik:
                count_k = total_per_kelas[k]
                count_val = len(df[(df['jenis_kelamin'] == val) & (df['real_target'] == k)])
                prob = (count_val + 1) / (count_k + len(kategori))
                row[str(k)] = prob
            jenis_kelamin_rows.append(row)

    # --- Likelihood Jurusan ---
    jurusan_rows = []
    if 'jurusan' in df.columns:
        kategori = df['jurusan'].dropna().unique()
        for val in kategori:
            decoded_val = jurusan_decode.get(val, val) if jurusan_decode else val   # decode di sini
            row = {"Pilihan": decoded_val}
            for k in kelas_unik:
                count_k = total_per_kelas[k]
                count_val = len(df[(df['jurusan'] == val) & (df['real_target'] == k)])
                prob = (count_val + 1) / (count_k + len(kategori))
                row[str(k)] = prob
            jurusan_rows.append(row)

    # --- Likelihood Pertanyaan ---
    pertanyaan_rows = []
    pertanyaan_cols = [f"P{i}" for i in range(1, 16)]
    n_kategori = 5
    for col in pertanyaan_cols:
        for pilihan in range(1, n_kategori+1):
            row = {"Pertanyaan": col, "Pilihan": pilihan}
            for k in kelas_unik:
                count_k = total_per_kelas[k]
                count_val = len(df[(df[col] == pilihan) & (df['real_target'] == k)])
                prob = (count_val + 1) / (count_k + n_kategori)
                row[str(k)] = prob
            pertanyaan_rows.append(row)

    return prior_prob, total_per_kelas, total_data, jenis_kelamin_rows, jurusan_rows, pertanyaan_rows
